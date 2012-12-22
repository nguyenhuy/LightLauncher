//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandManager.h"
#import "LLAppDelegate.h"
#import "LLCommandPrototype.h"
#import "LLCommandParser.h"
#import "LLCommandCompiler.h"
#import "LLCommandPrototypeFactory.h"
#import "Group.h"
#import "Receipt.h"

@interface LLCommandManager ()

@property (nonatomic, strong, readwrite) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readwrite) LLCommand *executingCommand;
@property (nonatomic, strong, readwrite) LLCommandPrototype *executingCommandPrototype;

+ (BOOL)save;
+ (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context;

- (void)initCommandPrototypes;
@end

@implementation LLCommandManager

+ (id)sharedInstance{
    static LLCommandManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LLCommandManager alloc] init];
    });
    return instance;
}

#pragma mark - CoreData related methods

+ (BOOL)save {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    return [LLCommandManager saveManagedObjectContext:context];
}

+ (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context {
    if (!context) {
        return NO;
    }
    //@TODO may need to handle error here
    [context MR_saveNestedContexts];
    return YES;
}

+ (Group *)defaultGroup {
    Group *group = [Group MR_findFirstByAttribute:@"name" withValue:DEFAULT_GROUP_NAME];
    if (group) {
        return group;
    }
    // No default group, create it
    return [LLCommandManager createGroupWithName:DEFAULT_GROUP_NAME];
}

+ (NSArray *)loadReceiptsFromDB {
    return [Receipt MR_findAllSortedBy:@"executedDate" ascending:NO];
}

+ (NSArray *)loadGroupsFromDB {
    return [Group MR_findAllSortedBy:@"name" ascending:YES];
}

+ (Group *)createGroupWithName:(NSString *)name {
    if ([name isEmpty]) {
        return NO;
    }
    
    Group *group = [Group MR_createEntity];
    group.name = name;

    if ([LLCommandManager save]) {
        return group;
    }
    return nil;
}

+ (BOOL)createReceiptInDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return NO;
    }
    
    Receipt *receipt = [Receipt MR_createEntity];
    receipt.data = [LLCommandParser encode:commandPrototype];
    receipt.executedDate = [NSDate date];
    receipt.group = nil;
    
    return [LLCommandManager save];
}

+ (BOOL)deleteAllReceipts {
    BOOL deleted = [Receipt MR_truncateAll];
    return deleted && [LLCommandManager save];
}

+ (BOOL)deleteReceipt:(Receipt *)receipt {
    if (!receipt) {
        return NO;
    }
    
    BOOL deleted = [receipt MR_deleteEntity];
    return deleted && [LLCommandManager save];
}

+ (BOOL)assignDefaultGroupForReceipt:(Receipt *)receipt withDescription:(NSString *)description {
    return [LLCommandManager assignGroup:[LLCommandManager defaultGroup] forReceipt:receipt withDescription:description];
}

+ (BOOL)assignGroup:(Group *)group forReceipt:(Receipt *)receipt withDescription:(NSString *)description {
    if (!receipt) {
        return NO;
    }
    
    receipt.group = group;
    if (![description isEmpty]) {
        // This call can be expensive, so only set if neccessary for now
        [receipt setDesc:description];
    }
    return [LLCommandManager save];
}

+ (BOOL)removeGroupForReceipt:(Receipt *)receipt {
    return [LLCommandManager assignGroup:nil forReceipt:receipt withDescription:nil];
}

#pragma mark - Instance methods

- (id)init {
    self = [super init];
    if (self != nil) {
        [self initCommandPrototypes];
    }
    return self;
}

- (void)initCommandPrototypes {
    self.commandPrototypes = [NSMutableArray arrayWithObjects:
                              [LLCommandPrototypeFactory emailCommandPrototype],
                              [LLCommandPrototypeFactory facebookCommandPrototype],
                              [LLCommandPrototypeFactory twitterCommandPrototype],
                              nil];
}

- (void)executeFromString:(NSString *)string withCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController {
    // @TODO: maybe need to decompile instead
    //    LLCommand *command = [LLCommandParser decode:string];
    //    [self executeFromCommand:command withCommandPrototype:commandPrototype withViewController:viewController];
}

- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController {
    self.executingCommandPrototype = commandPrototype;
    self.executingCommand = [LLCommandCompiler compile:self.executingCommandPrototype];
    [self.executingCommand executeWithViewController:viewController withCommandDelegate:self];
}

#pragma mark Command Delegate

- (void)onCommandFinished:(id)command {
    self.executingCommand = nil;
    [LLCommandManager createReceiptInDbFromCommandPrototype:self.executingCommandPrototype];
    self.executingCommandPrototype = nil;
}

@end

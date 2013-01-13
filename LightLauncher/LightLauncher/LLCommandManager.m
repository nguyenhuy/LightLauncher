//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandManager.h"
#import "LLSavingTimeManager.h"
#import "LLAppDelegate.h"
#import "LLCommandPrototype.h"
#import "LLCommandParser.h"
#import "LLCommandPrototypeFactory.h"
#import "Group.h"
#import "Receipt.h"

@interface LLCommandManager ()

@property (nonatomic, strong, readwrite) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readwrite) LLCommand *executingCommand;
@property (nonatomic, strong, readwrite) LLCommandPrototype *executingCommandPrototype;
@property (nonatomic, strong, readwrite) UIViewController *executingViewController;

+ (BOOL)save;
+ (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context;

- (void)initCommandPrototypes;
- (void)cleanUpAfterExecutingCommand;
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

+ (Group *)createGroupWithName:(NSString *)name {
    if (!name || name.length == 0) {
        return NO;
    }
    
    Group *group = [Group MR_createEntity];
    group.name = name;

    if ([LLCommandManager save]) {
        return group;
    }
    return nil;
}

+ (Receipt *)createReceiptInDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return NO;
    }
    
    Receipt *receipt = [Receipt MR_createEntity];
    receipt.data = [LLCommandParser encode:commandPrototype];
    receipt.executedDate = [NSDate date];
    receipt.group = nil;
    
    if ([LLCommandManager save]) {
        return receipt;
    }
    //@TODO can't save, show user something
    return nil;
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
    if (description && description.length != 0) {
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

- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController andDelegate:(id<LLCommandDelegate>)delegate {
    self.executingCommandPrototype = commandPrototype;
    self.executingCommandDelegate = delegate;
    self.executingViewController = viewController;

    [[[LLCommandCompiler alloc] init] compile:self.executingCommandPrototype withDelegate:self];
}

#pragma mark - Command compiler delegate

- (void)onFinishedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withCompiledValue:(id)compiledValue {
    self.executingCommand = compiledValue;
    [self.executingCommand executeWithViewController:self.executingViewController withCommandDelegate:self];
}

- (void)onFailedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withError:(NSError *)error {
    //@TODO change this to handle error better
    [self onStoppedCommand:nil withErrorTitle:@"Failed compiling command" andErrorDesc:@"Failed compiling command"];
}

#pragma mark Command Delegate

- (void)onFinishedCommand:(LLCommand *)command {
    [LLCommandManager createReceiptInDbFromCommandPrototype:self.executingCommandPrototype];
    [LLSavingTimeManager increaseSavingTimeWithCommand:self.executingCommand];
    [self.executingCommandDelegate onFinishedCommand:command];
    [self cleanUpAfterExecutingCommand];
}

- (void)onCanceledCommand:(LLCommand *)command {
    //@TODO should we save it???
    [LLCommandManager createReceiptInDbFromCommandPrototype:self.executingCommandPrototype];
    if ([self.executingCommandDelegate respondsToSelector:@selector(onCanceledCommand:)]) {
        [self.executingCommandDelegate onCanceledCommand:command];
    }
    [self cleanUpAfterExecutingCommand];
}

- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    //@TODO should we save it???
    [LLCommandManager createReceiptInDbFromCommandPrototype:self.executingCommandPrototype];
    [self.executingCommandDelegate onStoppedCommand:command withErrorTitle:title andErrorDesc:desc];
    [self cleanUpAfterExecutingCommand];
}

- (void)cleanUpAfterExecutingCommand {
    self.executingCommand = nil;
    self.executingCommandPrototype = nil;
    self.executingViewController = nil;
    self.executingCommandDelegate = nil;
}

@end

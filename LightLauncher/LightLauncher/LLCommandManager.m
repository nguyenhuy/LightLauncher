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
#import "Receipt.h"

@interface LLCommandManager ()
@property (nonatomic, strong, readwrite) NSMutableArray *receipts;
@property (nonatomic, strong, readwrite) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readwrite) LLCommand *executingCommand;
@property (nonatomic, strong, readwrite) LLCommandPrototype *executingCommandPrototype;
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
    [LLCommandManager saveReceiptToDbFromCommandPrototype:self.executingCommandPrototype];
    self.executingCommandPrototype = nil;
}

#pragma mark - Static methods

+ (BOOL)save {
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    return [self saveManagedObjectContext:context];
}

+ (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context {
    if (!context) {
        return NO;
    }
    
    NSError *error = nil;
    BOOL saved = [context save:&error];
    //@TODO save to Crittercism
    if (saved) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
    return saved;
}


+ (BOOL)saveReceiptToDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return NO;
    }
    
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    Receipt *command = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME_RECEIPT inManagedObjectContext:context];
    command.liked = [NSNumber numberWithBool:NO];
    command.data = [LLCommandParser encode:commandPrototype];
    command.executedDate = [NSDate date];
    
    return [self saveManagedObjectContext:context];
}

+ (NSArray *)loadReceiptsFromDB {
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest new];
    
    // Receipt entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_RECEIPT inManagedObjectContext:context];
    request.entity = entity;
    
    // Sort using executedDate, in descending order
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:ENTITY_KEY_EXECUTED_DATE ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sortDesc];
    
    NSError *error = nil;
    NSArray *fetchedReceipts = [context executeFetchRequest:request error:&error];
    
    if (error) {
        //@TODO log to Crittercism here
        return nil;
    }
    
    // Parse all receipts
    //@TODO should we do it here???
    // If don't parse them here, should do it in LLHistoryTableViewController:tableView: didSelectRowAtIndexPath:
    for (Receipt *r in fetchedReceipts) {
        r.commandPrototype = [LLCommandParser decode:r.data];
    }
    
    return fetchedReceipts;
}

+ (BOOL)deleteAllReceipts {
    NSArray *receipts = [self loadReceiptsFromDB];
    
    if (!receipts || [receipts count] == 0) {
        // Nothing to delete, return YES to indicate that there is no receipt in DB.
        return YES;
    }
    
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    for (Receipt *r in receipts) {
        [context deleteObject:r];
    }
    
    return [self saveManagedObjectContext:context];
}

+ (BOOL)deleteReceipt:(Receipt *)receipt {
    if (!receipt) {
        return NO;
    }
    
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    [context deleteObject:receipt];
    return [self saveManagedObjectContext:context];
}

@end

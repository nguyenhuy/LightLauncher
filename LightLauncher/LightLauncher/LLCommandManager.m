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
@property (nonatomic, strong, readwrite) NSMutableArray *favReceipts;
@property (nonatomic, strong, readwrite) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readwrite) LLCommand *executingCommand;
@property (nonatomic, strong, readwrite) LLCommandPrototype *executingCommandPrototype;

+ (NSMutableArray *)loadReceiptsFromDB;
+ (BOOL)save;
+ (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context;

- (void)initReceipts;
- (void)initFavReceipts;
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

+ (NSMutableArray *)receipts {
    return [[LLCommandManager sharedInstance] receipts];
}

+ (NSMutableArray *)favReceipts {
    return [[LLCommandManager sharedInstance] favReceipts];
}

+ (NSMutableArray *)commandPrototypes {
    return [[LLCommandManager sharedInstance] commandPrototypes];
}

+ (BOOL)save {
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    return [LLCommandManager saveManagedObjectContext:context];
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

+ (NSMutableArray *)loadReceiptsFromDB {
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest new];
    
    // Receipt entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_RECEIPT inManagedObjectContext:context];
    request.entity = entity;
    
    // Sort using executedDate, in descending order
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:ENTITY_KEY_EXECUTED_DATE ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDesc];
    
    NSError *error = nil;
    NSArray *fetchedReceipts = [context executeFetchRequest:request error:&error];
    
    if (error) {
        //@TODO log to Crittercism here
        return nil;
    }
    
    return [NSMutableArray arrayWithArray:fetchedReceipts];
}

- (id)init {
    self = [super init];
    if (self != nil) {
        [self initReceipts];
        [self initFavReceipts];
        [self initCommandPrototypes];
    }
    return self;
}

- (void)initReceipts {
    self.receipts = [LLCommandManager loadReceiptsFromDB];
}

- (void)initFavReceipts {
    self.favReceipts = [[NSMutableArray alloc] init];
    for (Receipt* r in self.receipts) {
        if (r.likedValue) {
            [self.favReceipts addObject:r];
        }
    }
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
    [[LLCommandManager  sharedInstance] saveReceiptToDbFromCommandPrototype:self.executingCommandPrototype];
    self.executingCommandPrototype = nil;
}

#pragma mark - Instance methods

- (BOOL)saveReceiptToDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return NO;
    }
    
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    Receipt *receipt = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME_RECEIPT inManagedObjectContext:context];
    receipt.likedValue = NO;
    receipt.data = [LLCommandParser encode:commandPrototype];
    receipt.executedDate = [NSDate date];
    
    BOOL saved = [LLCommandManager saveManagedObjectContext:context];
    if (saved) {
        [self.receipts addObject:receipt];
        if (receipt.likedValue) {
            [self.favReceipts addObject:receipt];
        }
    }
    return saved;
}

- (BOOL)deleteAllReceipts {
    if ([self.receipts count] == 0) {
        // Nothing to delete, return YES to indicate that there is no receipt in DB.
        return YES;
    }
    
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    for (Receipt *r in self.receipts) {
        [context deleteObject:r];
    }
    
    BOOL saved = [LLCommandManager saveManagedObjectContext:context];
    if (saved) {
        [self.receipts removeAllObjects];
        [self.favReceipts removeAllObjects];
    }
    return saved;
}

- (BOOL)deleteReceiptAtIndex:(int)index {
    Receipt *receipt = [self.receipts objectAtIndex:index];
    if (!receipt) {
        return NO;
    }
    
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    [context deleteObject:receipt];
    BOOL saved = [LLCommandManager saveManagedObjectContext:context];
    if (saved) {
        [self.receipts removeObjectAtIndex:index];
        [self.favReceipts removeObject:receipt];
    }
    return saved;
}

#pragma mark - Update receipt methods

- (BOOL)toggleLikeOfReceiptAtIndex:(int)index {
    Receipt *receipt = [self.receipts objectAtIndex:index];
    if (!receipt) {
        return NO;
    }
    
    receipt.likedValue = !receipt.likedValue;
    
    BOOL saved = [LLCommandManager save];
    if (saved) {
        if (receipt.likedValue) {
            [self.favReceipts addObject:receipt];
        } else {
            [self.favReceipts removeObject:receipt];
        }
    }
    return saved;
}

@end

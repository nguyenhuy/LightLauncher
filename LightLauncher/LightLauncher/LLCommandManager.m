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
#import "HistoryReceipt.h"
#import "FavReceipt.h"

@interface LLCommandManager ()

@property (nonatomic, strong, readwrite) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readwrite) LLCommand *executingCommand;
@property (nonatomic, strong, readwrite) LLCommandPrototype *executingCommandPrototype;
@property (nonatomic, strong, readwrite) UIViewController *executingViewController;
@property (nonatomic, strong, readwrite) LLCommandCompiler *compiler;

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

+ (BOOL)createHistoryReceiptFromCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return NO;
    }
    
    HistoryReceipt *receipt = [HistoryReceipt MR_createEntity];
    receipt.data = [LLCommandParser encode:commandPrototype];
    receipt.executedDate = [NSDate date];
    
    if ([LLCommandManager save]) {
        return YES;
    }
    //@TODO can't save, show user something
    return NO;
}

+ (BOOL)deleteHistoryReceipt:(HistoryReceipt *)historyReceipt {
    if (!historyReceipt) {
        return NO;
    }
    
    BOOL deleted = [historyReceipt MR_deleteEntity];
    return deleted && [LLCommandManager save];
}

+ (BOOL)createFavReceiptFromCommandPrototype:(LLCommandPrototype *)commandPrototype withDescription:(NSString *)description {
    if (!commandPrototype) {
        return NO;
    }
    
    FavReceipt *receipt = [FavReceipt MR_createEntity];
    receipt.data = [LLCommandParser encode:commandPrototype];
    receipt.position = 0;
    [receipt setDesc:description];
    
    //@TODO shift other fav receipts in this group to the right.
    
    if ([LLCommandManager save]) {
        return YES;
    }
    //@TODO can't save, show user something
    return NO;
}

+ (BOOL)deleteFavReceipt:(FavReceipt *)favReceipt {
    if (!favReceipt) {
        return NO;
    }
    
    //@TODO shift other commanda to the left
    
    BOOL deleted = [favReceipt MR_deleteEntity];
    return deleted && [LLCommandManager save];
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
                              [LLCommandPrototypeFactory googlePlusCommandPrototype],
                              [LLCommandPrototypeFactory openInChromeCommandPrototype],
                              [LLCommandPrototypeFactory instapaperAddCommandPrototype],
                              nil];
}

- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController andDelegate:(id<LLCommandDelegate>)delegate {
    self.executingCommandPrototype = commandPrototype;
    self.executingCommandDelegate = delegate;
    self.executingViewController = viewController;

    self.compiler = [[LLCommandCompiler alloc] init];
    [self.compiler compile:self.executingCommandPrototype withDelegate:self andViewController:self.executingViewController];
}

#pragma mark - Command compiler delegate

- (void)onFinishedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withCompiledValue:(id)compiledValue {
    self.compiler = nil;
    self.executingCommand = compiledValue;
    [self.executingCommand executeWithViewController:self.executingViewController withCommandDelegate:self];
}

- (void)onFailedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withError:(NSError *)error {
    //@TODO change this to handle error better
    [self onStoppedCommand:nil withErrorTitle:@"Failed compiling command" andErrorDesc:error.localizedDescription];
}

#pragma mark Command Delegate

- (void)onFinishedCommand:(LLCommand *)command {
    [LLCommandManager createHistoryReceiptFromCommandPrototype:self.executingCommandPrototype];
    [LLSavingTimeManager increaseSavingTimeWithCommand:self.executingCommand];
    [self.executingCommandDelegate onFinishedCommand:command];
    [self cleanUpAfterExecutingCommand];
}

- (void)onCanceledCommand:(LLCommand *)command {
    //@TODO should we save it???
    [LLCommandManager createHistoryReceiptFromCommandPrototype:self.executingCommandPrototype];
    if ([self.executingCommandDelegate respondsToSelector:@selector(onCanceledCommand:)]) {
        [self.executingCommandDelegate onCanceledCommand:command];
    }
    [self cleanUpAfterExecutingCommand];
}

- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    //@TODO should we save it???
    [LLCommandManager createHistoryReceiptFromCommandPrototype:self.executingCommandPrototype];
    [self.executingCommandDelegate onStoppedCommand:command withErrorTitle:title andErrorDesc:desc];
    [self cleanUpAfterExecutingCommand];
}

- (void)cleanUpAfterExecutingCommand {
    self.executingCommand = nil;
    self.executingCommandPrototype = nil;
    self.executingViewController = nil;
    self.executingCommandDelegate = nil;
    self.compiler = nil;
}

@end

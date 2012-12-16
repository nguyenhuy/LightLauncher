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
#import "Command.h"

@interface LLCommandManager ()
@property (nonatomic, strong, readwrite) NSMutableArray *receipts;
@property (nonatomic, strong, readwrite) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readwrite) LLCommand *executingCommand;
@property (nonatomic, strong, readwrite) LLCommandPrototype *executingCommandPrototype;
- (void)initReceipts;
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
        [self initReceipts];
        [self initCommandPrototypes];
    }
    return self;
}

- (void)initReceipts {
    self.receipts = [NSMutableArray new];
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
    [LLCommandManager saveToDbCommandPrototype:self.executingCommandPrototype];
    self.executingCommandPrototype = nil;
}

+ (BOOL)saveToDbCommandPrototype:(LLCommandPrototype *)commandPrototype {
    NSManagedObjectContext *context = [LLAppDelegate sharedInstance].managedObjectContext;
    
    Command *command = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME_COMMAND inManagedObjectContext:context];
    command.liked = NO;
    command.data = [LLCommandParser encode:commandPrototype];
    command.executedDate = [NSDate date];
    
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

@end

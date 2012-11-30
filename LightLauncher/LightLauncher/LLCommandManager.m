//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandManager.h"

#import "LLCommandParser.h"
#import "LLCommandCompiler.h"

#import "LLCommandPrototypeFactory.h"

#import "LLTwitterCommand.h"
#import "LLEmailCommand.h"
#import "LLFacebookCommand.h"

@interface LLCommandManager ()
@property (nonatomic, strong, readwrite) NSMutableArray* receipts;
@property (nonatomic, strong, readwrite) NSMutableArray* commandPrototypes;
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
    LLCommand *compiledCommand = [LLCommandCompiler compile:commandPrototype];
    [compiledCommand executeFromViewController:viewController];
}

@end

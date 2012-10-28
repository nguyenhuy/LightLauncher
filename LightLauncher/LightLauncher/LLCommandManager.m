//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandManager.h"
#import "LLCommandParser.h"

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
                     [LLEmailCommand commandPrototype],
                     [LLTwitterCommand commandPrototype],
                     [LLFacebookCommand commandPrototype],
                     nil];
}

- (void)executeFromString:(NSString *)string withViewController:(UIViewController *)viewController{
    LLCommand *command = [LLCommandParser decode:string];
    [self executeFromCommand:command withViewController:viewController];
}

- (void)executeFromCommand:(LLCommand *)command withViewController:(UIViewController *)viewController{
    [command executeFromViewController:viewController];
}

@end

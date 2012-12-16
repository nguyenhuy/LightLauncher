//
//  LLReceiptManager.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLCommand.h"

@class LLCommandPrototype;

@interface LLCommandManager : NSObject <LLCommandDelegate>

@property (nonatomic, strong, readonly) NSMutableArray *receipts;
@property (nonatomic, strong, readonly) NSMutableArray *commandPrototypes;
@property (nonatomic, strong, readonly) LLCommand *executingCommand;

+ (LLCommandManager *)sharedInstance;

- (void)executeFromString:(NSString *)string withCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;
- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;
+ (BOOL)saveToDbCommandPrototype:(LLCommandPrototype *)commandPrototype;

@end

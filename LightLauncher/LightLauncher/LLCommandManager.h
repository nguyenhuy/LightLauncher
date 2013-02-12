//
//  LLReceiptManager.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"
#import "LLCommandCompiler.h"

@class LLCommandPrototype;
@class HistoryReceipt;
@class FavReceipt;

@interface LLCommandManager : NSObject <LLCommandDelegate, LLCommandCompilerDelegate>

@property (nonatomic, strong, readonly) NSMutableArray *commandPrototypes;

@property (nonatomic, strong, readonly) LLCommandPrototype *executingCommandPrototype;
@property (nonatomic, strong, readonly) LLCommand *executingCommand;
@property (nonatomic, strong, readonly) UIViewController *executingViewController;
@property (nonatomic, strong, readonly) LLCommandCompiler *compiler;
@property (nonatomic, weak) id<LLCommandDelegate> executingCommandDelegate;

+ (LLCommandManager *)sharedInstance;
+ (BOOL)createHistoryReceiptFromCommandPrototype:(LLCommandPrototype *)commandPrototype;
+ (BOOL)deleteHistoryReceipt:(HistoryReceipt *)historyReceipt;
+ (BOOL)createFavReceiptFromCommandPrototype:(LLCommandPrototype *)commandPrototype withDescription:(NSString *)description;
+ (BOOL)deleteFavReceipt:(FavReceipt *)favReceipt;

- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController andDelegate:(id<LLCommandDelegate>)delegate;

@end

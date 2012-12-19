//
//  LLReceiptManager.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@class LLCommandPrototype;
@class Receipt;

@interface LLCommandManager : NSObject <LLCommandDelegate>

@property (nonatomic, strong, readonly) NSMutableArray *receipts;
@property (nonatomic, strong, readonly) NSMutableArray *favReceipts;
@property (nonatomic, strong, readonly) NSMutableArray *commandPrototypes;

@property (nonatomic, strong, readonly) LLCommandPrototype *executingCommandPrototype;
@property (nonatomic, strong, readonly) LLCommand *executingCommand;

+ (LLCommandManager *)sharedInstance;
//@TODO are they a good idea??? it looks we're simulating static variables
+ (NSMutableArray *)receipts;
+ (NSMutableArray *)favReceipts;
+ (NSMutableArray *)commandPrototypes;

- (void)executeFromString:(NSString *)string withCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;
- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;

- (BOOL)saveReceiptToDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype;
- (BOOL)deleteAllReceipts;
- (BOOL)deleteReceiptAtIndex:(int)index;

#pragma mark - Update receipt methods
- (BOOL)toggleLikeOfReceiptAtIndex:(int)index;

@end

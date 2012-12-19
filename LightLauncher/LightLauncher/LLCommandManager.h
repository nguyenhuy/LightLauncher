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

@property (nonatomic, strong, readonly) NSMutableArray *commandPrototypes;

@property (nonatomic, strong, readonly) LLCommandPrototype *executingCommandPrototype;
@property (nonatomic, strong, readonly) LLCommand *executingCommand;

+ (LLCommandManager *)sharedInstance;

- (void)executeFromString:(NSString *)string withCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;
- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;
+ (BOOL)save;
+ (BOOL)saveManagedObjectContext:(NSManagedObjectContext *)context;
+ (BOOL)saveReceiptToDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype;
//@TODO may cache in this instance
+ (NSArray *)loadReceiptsFromDB;
+ (BOOL)deleteAllReceipts;
+ (BOOL)deleteReceipt:(Receipt *)receipt;

@end

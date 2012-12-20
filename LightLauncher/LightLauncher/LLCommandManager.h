//
//  LLReceiptManager.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@class LLCommandPrototype;
@class Group;
@class Receipt;

@interface LLCommandManager : NSObject <LLCommandDelegate>

@property (nonatomic, strong, readonly) NSMutableArray *commandPrototypes;

@property (nonatomic, strong, readonly) LLCommandPrototype *executingCommandPrototype;
@property (nonatomic, strong, readonly) LLCommand *executingCommand;

+ (LLCommandManager *)sharedInstance;
+ (Group *)defaultGroup;
+ (NSArray *)loadGroupsFromDB;
+ (NSArray *)loadReceiptsFromDB;
+ (Group *)createGroupWithName:(NSString *)name;
+ (BOOL)createReceiptInDbFromCommandPrototype:(LLCommandPrototype *)commandPrototype;
+ (BOOL)deleteAllReceipts;
+ (BOOL)deleteReceipt:(Receipt *)receipt;
+ (BOOL)assignDefaultGroupForReceipt:(Receipt *)receipt;
+ (BOOL)assignGroup:(Group *)group forReceipt:(Receipt *)receipt;
+ (BOOL)removeGroupOfReceipt:(Receipt *)receipt;

- (void)executeFromString:(NSString *)string withCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;
- (void)executeFromCommandPrototype:(LLCommandPrototype *)commandPrototype withViewController:(UIViewController *)viewController;

@end

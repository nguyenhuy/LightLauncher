//
//  LLReceiptManager.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLReceiptManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *receipts;
@property (nonatomic, strong, readonly) NSMutableArray *commands;

- (void)executeCommand:(NSString *)command;

@end

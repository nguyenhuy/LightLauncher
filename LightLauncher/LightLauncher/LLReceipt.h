//
//  LLReceipt.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  LLCommand;

@interface LLReceipt : NSObject

@property (strong, nonatomic) LLCommand* command;
@property (strong, nonatomic) NSDate* lastUsed;

@end

//
//  LLReceipt.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class  LLCommand;

@interface LLReceipt : NSObject

@property (nonatomic, strong) LLCommand* command;
@property (nonatomic, strong) NSDate* lastUsed;

@end

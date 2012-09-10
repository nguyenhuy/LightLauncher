//
//  LLTwitterCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@class LLImageOption;
@class LLUrlOption;
@class LLBodyOption;

@interface LLTwitterCommand : LLCommand

@property (nonatomic, strong) LLBodyOption *bodyOption;
@property (nonatomic, strong) LLUrlOption *urlOption;
@property (nonatomic, strong) LLImageOption *imageOption;

@end

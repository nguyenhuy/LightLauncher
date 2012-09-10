//
//  LLStringOption.h
//  LightLauncher
//
//  Created by Huy Nguyen on 9/11/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOption.h"

@interface LLStringOption : LLOption

@property (nonatomic, strong) NSString* param;

- (id)initWithParam:(NSString *)param;

@end

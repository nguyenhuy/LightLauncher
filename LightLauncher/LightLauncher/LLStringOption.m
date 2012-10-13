//
//  LLStringOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 9/11/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLStringOption.h"

@implementation LLStringOption

- (id)initWithParam:(NSString *)param {
    self = [super init];
    if (self) {
        self.param = param;
    }
    return self;
}

- (NSString *)description {
    return @"String";
}

@end

//
//  LLUrlOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 9/11/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLUrlOption.h"

@implementation LLUrlOption

- (NSString *)description {
    return @"Url";
}

- (NSURL *)url {
    return [NSURL URLWithString:self.param];
}

@end

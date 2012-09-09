//
//  LLOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOption.h"

@implementation LLOption

@synthesize name = _name;
@synthesize param = _param;

- (id)initWithParam:(NSString *)param {
    self = [super init];
    if (self) {
        self.param = param;
    }
    return self;
}

- (NSString *)description {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"desction must be overridden in all commadns" userInfo:nil];
}

@end

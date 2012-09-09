//
//  LLBodyOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 9/9/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLBodyOption.h"

@implementation LLBodyOption

@synthesize isHtml = _isHtml;

- (id)initWithParam:(NSString *)param AndIsHtml:(BOOL)isHtml {
    self = [super initWithParam:param];
    if (self) {
        self.isHtml = isHtml;
    }
    return self;
}

- (NSString *)description {
    return @"Body";
}

@end

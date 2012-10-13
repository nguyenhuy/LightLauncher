//
//  LLImageOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 9/11/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLImageOption.h"

@implementation LLImageOption

- (id)initWithWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

- (NSString *)description {
    return @"Image";
}

@end

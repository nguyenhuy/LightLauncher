//
//  LLCommandPrototype.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/2/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandPrototype.h"

@implementation LLCommandPrototype

- (LLCommandPrototype *)initWithCommand:(LLCommand *)command andOptions:(NSArray *)options {
    self = [super init];
    if (self) {
        self.command = command;
        self.options = options;
    }
    return self;
}

@end

//
//  LLCommandPrototype.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/2/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandPrototype.h"

@interface LLCommandPrototype ()
@property (nonatomic, strong, readwrite) NSString *command;
// An array of LLOptionPrototype
@property (nonatomic, strong, readwrite) NSArray *options;
@end

@implementation LLCommandPrototype

- (LLCommandPrototype *)initWithCommand:(NSString *)command andOptions:(NSArray *)options {
    self = [super init];
    if (self) {
        self.command = command;
        self.options = options;
    }
    return self;
}

@end

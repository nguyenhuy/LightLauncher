//
//  LLCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@implementation LLCommand

- (id)init {
    self = [super init];
    if(self) {
        self.options = [NSMutableDictionary new];
    }
    return self;
}

- (id)valueForKey:(NSString *)key {
    return [self.options valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [self.options setValue:value forKey:key];
}

- (void)addValue:(id)value forKey:(NSString *)key {
    NSMutableArray *array = [self.options valueForKey:key];
    if (array == nil) {
        array = [NSMutableArray new];
        [self.options setValue:array forKey:key];
    }
    [array addObject:value];
}

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    self.delegate = delegate;
}

- (void)onFinished {
    [self.delegate onCommandFinished:self];
    self.delegate = nil;
}

- (id)copyWithZone:(NSZone *)zone {
    LLCommand *newCopy = [[self.class alloc] init];
    newCopy.options = [[NSMutableDictionary alloc] initWithDictionary:self.options copyItems:YES];
    return newCopy;
}

@end

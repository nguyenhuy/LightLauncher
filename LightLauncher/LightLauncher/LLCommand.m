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

+ (LLCommand *)commandPrototype {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"commandPrototype must be implemented" userInfo:nil];
}

+ (NSString *)command {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"command must be implemented" userInfo:nil];
}

+ (NSString *)description {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"description must be implemented" userInfo:nil];
}

+ (NSString *)iconFileName {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"iconFileName must be implemented" userInfo:nil];
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

- (void)executeFromViewController:(UIViewController *)viewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"execute must be implemented" userInfo:nil];
}

@end

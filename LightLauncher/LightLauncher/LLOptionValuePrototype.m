//
//  LLOptionValuePrototype.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/5/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionValuePrototype.h"

@interface LLOptionValuePrototype ()
@property (nonatomic, strong, readwrite) NSString *key;
@property (nonatomic, strong, readwrite) NSString *displayName;
@property (nonatomic, readwrite) OptionValueType type;
@end

@implementation LLOptionValuePrototype

- (id)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName andType:(OptionValueType)type {
    self = [super init];
    if (self) {
        self.key = key;
        self.displayName = displayName;
        self.type = type;
    }
    return self;
}

@end

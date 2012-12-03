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

- (LLOptionValuePrototype *)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName andType:(OptionValueType)type {
    self = [super init];
    if (self) {
        self.key = key;
        self.displayName = displayName;
        self.type = type;
        self.selected = NO;
        self.value = nil;
    }
    return self;
}

- (NSString *)valueString {
    if (self.value == nil) {
        return nil;
    }
    
    if ([self.value isKindOfClass:[NSString class]]){
        return self.value;
    }
    
    if ([self.value isKindOfClass:[NSArray class]]) {
        return [self.value componentsJoinedByString:@", "];
    }
    
    return nil;
}

- (BOOL)selected {
    if ([self.key isEqualToString:OPTION_VALUE_PREFILL]) {
        return _selected && [self.value isEmpty];
    }
    return _selected;
}

@end

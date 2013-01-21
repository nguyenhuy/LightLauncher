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
@end

@implementation LLOptionValuePrototype

- (LLOptionValuePrototype *)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName {
    self = [super init];
    if (self) {
        self.key = key;
        self.displayName = displayName;
        self.selected = NO;
        self.value = nil;
    }
    return self;
}

//- (BOOL)selected {
//    if ([self.key isEqualToString:OPTION_VALUE_PREFILL]) {
//        return _selected && [self.value length] != 0;
//    }
//    return _selected;
//}

@end

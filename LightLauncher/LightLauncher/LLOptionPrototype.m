//
//  LLOptionPrototype.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionPrototype.h"

@interface LLOptionPrototype ()
@property (nonatomic, strong, readwrite) NSString *key;
@property (nonatomic, strong, readwrite) NSString *displayName;
@property (nonatomic, readwrite) OptionDataType dataType;
@property (nonatomic, strong, readwrite) NSDictionary *possibleValues;
@end

@implementation LLOptionPrototype

- (LLOptionPrototype *)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName andDataType:(OptionDataType)dataType andPossibleValues:(NSDictionary *)possibleValues {
    self = [super init];
    if (self) {
        self.key = key;
        self.displayName = displayName;
        self.dataType = dataType;
        self.possibleValues = possibleValues;
    }
    return self;
}

- (LLOptionValuePrototype *)possibleValueForKey:(NSString *)key {
    return [self.possibleValues objectForKey:key];
}

- (BOOL)containPossibleValueForKey:(NSString *)key {
    return [self.possibleValues objectForKey:key] != nil;
}

@end

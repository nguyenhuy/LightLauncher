//
//  LLOptionPrototype.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionPrototype.h"

@implementation LLOptionPrototype

- (LLOptionPrototype *)initWithName:(NSString *)name andDisplayName:(NSString *)displayName andPossibleValues:(NSDictionary *)possibleValues {
    self = [super init];
    if (self) {
        self.name = name;
        self.displayName = displayName;
        self.possibleValues = possibleValues;
    }
    return self;
}

@end

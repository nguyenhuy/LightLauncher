//
//  Receipt.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "Receipt.h"
#import "Group.h"
#import "LLCommandParser.h"

@implementation Receipt

@dynamic data;
@dynamic executedDate;
@dynamic group;
@synthesize commandPrototype = _commandPrototype;

- (LLCommandPrototype *)commandPrototype {
    if (!_commandPrototype) {
        // Parse when needed
        _commandPrototype = [LLCommandParser decode:self.data];
    }
    return _commandPrototype;
}

- (BOOL)liked {
    return self.group != nil;
}

@end

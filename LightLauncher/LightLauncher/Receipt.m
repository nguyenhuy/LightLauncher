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
#import "LLCommandPrototype.h"

@implementation Receipt

@dynamic data;
@synthesize commandPrototype = _commandPrototype;

- (LLCommandPrototype *)commandPrototype {
    if (!_commandPrototype) {
        // Parse when needed
        _commandPrototype = [LLCommandParser decode:self.data];
    }
    return _commandPrototype;
}

- (void)setDesc:(NSString *)desc {
    // Call to commandPrototype getter will parse the data if needed
    self.commandPrototype.desc = desc;
    // Encode back to data
    self.data = [LLCommandParser encode:self.commandPrototype];
}

@end

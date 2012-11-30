//
//  LLCommandCompiler.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandCompiler.h"

#import "Constants.h"

#import "LLCommand.h"
#import "LLCommandPrototype.h"
#import "LLOptionPrototype.h"

@implementation LLCommandCompiler

+ (LLCommand *)compile:(const LLCommand *)rawCommand withCommandPrototype:(LLCommandPrototype *)commandPrototype {
    LLCommand *compiledCommand = [rawCommand copy];
    for (LLOptionPrototype *optionPrototype in commandPrototype.options) {
        NSObject *value = [compiledCommand valueForKey:optionPrototype.key];
        if (value) {
            NSString *compiledValue;
            NSString *value = nil;
            if ([value isKindOfClass:[NSString class]]) {
                if ([optionPrototype.key isEqualToString:OPTION_VALUE_PASTEBOARD]) {
                    compiledValue = @"Pasteboard";
                } else if ([optionPrototype.key isEqualToString:OPTION_VALUE_PREFILL]) {
                    compiledValue = (NSString *) value;
                }
            } else if([value isKindOfClass:[NSArray class]]) {
                compiledValue = [((NSArray *) value) componentsJoinedByString:@", "];
            }
            [compiledValue setValue:compiledValue forKey:optionPrototype.key];
        }
    }
    return compiledCommand;
}



@end

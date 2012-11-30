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
#import "LLOptionValuePrototype.h"

@interface LLCommandCompiler ()
+ (NSString *)optionValueFromPasteboardWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype;
@end

@implementation LLCommandCompiler

+ (LLCommand *)compile:(const LLCommand *)rawCommand withCommandPrototype:(LLCommandPrototype *)commandPrototype {
    LLCommand *compiledCommand = [rawCommand copy];
    for (LLOptionPrototype *optionPrototype in commandPrototype.options) {
        NSObject *value = [compiledCommand valueForKey:optionPrototype.key];
        if (value) {
            NSString *compiledValue;
            NSString *valueString = nil;
            if ([value isKindOfClass:[NSString class]]) {
                valueString = (NSString *) value;
                if ([valueString isEqualToString:OPTION_VALUE_PASTEBOARD]) {
                    LLOptionValuePrototype *optionValuePrototype = [optionPrototype possibleValueForKey:valueString];
                    compiledValue = [self optionValueFromPasteboardWithOptionValuePrototype:optionValuePrototype];
                } else {
                    // Prefill value
                    compiledValue = valueString;
                }
            } else if([value isKindOfClass:[NSArray class]]) {
                // Prefill value
                compiledValue = [((NSArray *) value) componentsJoinedByString:@", "];
            }
            [compiledValue setValue:compiledValue forKey:optionPrototype.key];
        }
    }
    return compiledCommand;
}

+ (NSString *)optionValueFromPasteboardWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype {
    // TODO: support different type (images, colors, data)
    UIPasteboard *pastebboard = [UIPasteboard generalPasteboard];
    return pastebboard.string;
}

@end

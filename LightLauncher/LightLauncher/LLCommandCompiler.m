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
+ (NSString *)compiledValueFromOptionValuePrototype:(LLOptionValuePrototype *)optionValue;
@end

@implementation LLCommandCompiler

+ (LLCommand *)compile:(LLCommandPrototype *)commandPrototype {
    LLCommand *compiledCommand = [commandPrototype.command copy];
    // @TODO refactor this
    for (LLOptionPrototype *option in commandPrototype.options) {
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            if (optionValue.selected) {
                NSString *compiledValue = [self compiledValueFromOptionValuePrototype:optionValue];
                [compiledCommand setValue:compiledValue forKey:option.key];
                continue;
            }
        }
    }
    return compiledCommand;
}

+ (NSString *)compiledValueFromOptionValuePrototype:(LLOptionValuePrototype *)optionValue {
    NSString *compiledValue;
    if (optionValue.value == nil) {
        if ([optionValue.key isEqualToString:OPTION_VALUE_PASTEBOARD]) {
            compiledValue = [self optionValueFromPasteboardWithOptionValuePrototype:optionValue];
        }
    } else {
        compiledValue = [optionValue valueString];
    }
    return compiledValue;
}

+ (NSString *)optionValueFromPasteboardWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype {
    // TODO: support different type (images, colors, data)
    UIPasteboard *pastebboard = [UIPasteboard generalPasteboard];
    return pastebboard.string;
}

@end

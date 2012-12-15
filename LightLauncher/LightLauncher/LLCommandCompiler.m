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
+ (id)optionValueFromPasteboardWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype;
+ (id)compiledValueForOption:(LLOptionPrototype *)option FromOptionValuePrototype:(LLOptionValuePrototype *)optionValue;
@end

@implementation LLCommandCompiler

+ (LLCommand *)compile:(LLCommandPrototype *)commandPrototype {
    LLCommand *compiledCommand = [commandPrototype.command copy];
    for (LLOptionPrototype *option in commandPrototype.options) {
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            if (optionValue.selected) {
                id compiledValue = [self compiledValueForOption:option FromOptionValuePrototype:optionValue];
                [compiledCommand setValue:compiledValue forKey:option.key];
                continue;
            }
        }
    }
    return compiledCommand;
}

+ (id)compiledValueForOption:(LLOptionPrototype *)option FromOptionValuePrototype:(LLOptionValuePrototype *)optionValue {
    id compiledValue;
    if (optionValue.value == nil) {
        if ([optionValue.key isEqualToString:OPTION_VALUE_PASTEBOARD]) {
            compiledValue = [self optionValueFromPasteboardWithOptionValuePrototype:optionValue];
        }
    } else if (option.dataType == DATA_ARRAY) {
        compiledValue = [optionValue.value componentsSeparatedByString:COMPONENTS_SEPARATOR];
    } else if (option.dataType == DATA_STRING) {
        compiledValue = optionValue.value;
    }
    return compiledValue;
}

+ (id)optionValueFromPasteboardWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype {
    // TODO: support different type (images, colors, data)
    UIPasteboard *pastebboard = [UIPasteboard generalPasteboard];
    return pastebboard.string;
}

@end

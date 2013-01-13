//
//  LLCommandCompiler.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandCompiler.h"

#import "LLCommandFactory.h"

#import "LLCommand.h"
#import "LLCommandPrototype.h"
#import "LLOptionPrototype.h"
#import "LLOptionValuePrototype.h"

@interface LLCommandCompiler ()
- (void)increaseCompilingCounter;
- (void)decreaseCompilingCounter;
- (void)cleanUpAfterCompiling;
- (void)compileValueForOption:(LLOptionPrototype *)option fromOptionValuePrototype:(LLOptionValuePrototype *)optionValue;
- (void)setCompiledValue:(id)compiledValue forOption:(LLOptionPrototype *)option;
- (void)pasteboardOptionValueForOption:(LLOptionPrototype *)option;
- (void)lastPhotoOptionValueForOption:(LLOptionPrototype *)option;
@end

@implementation LLCommandCompiler

- (void)decreaseCompilingCounter {
    @synchronized(self) {
        self.compilingCounter--;
        if (self.compilingCounter <= 0) {
            [self.delegate onFinishedCompilingCommandPrototype:self.compilingCommandPrototype withCompiledValue:self.compilingCommand];
            [self cleanUpAfterCompiling];
        }
    }
}

//@TODO call this when failed compiling as well
- (void)cleanUpAfterCompiling {
    @synchronized(self) {
        self.compilingCounter = 0;
    }

    self.compilingCommand = nil;
    self.compilingCommandPrototype = nil;
    self.delegate = nil;
}

-(void)compile:(LLCommandPrototype *)commandPrototype withDelegate:(id<LLCommandCompilerDelegate>)delegate {
    self.delegate = delegate;
    self.compilingCommand = [LLCommandFactory commandForString:commandPrototype.command];
    
    // Init compiling counter first
    // Since compiling can be executed in multiple threads, we should do this first
    // so that the counter won't be misbehaved
    for (LLOptionPrototype *option in commandPrototype.options) {
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            if (optionValue.selected) {
                self.compilingCounter++;
                continue;
            }
        }
    }

    for (LLOptionPrototype *option in commandPrototype.options) {
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            if (optionValue.selected) {
                [self compileValueForOption:option fromOptionValuePrototype:optionValue];
                continue;
            }
        }
    }
}

- (void)compileValueForOption:(LLOptionPrototype *)option fromOptionValuePrototype:(LLOptionValuePrototype *)optionValue {
    id compiledValue = optionValue.value;
    
    if (!compiledValue) {
        // If value is nil, it needs to be got at runtime.
        // Check and get it now
        if ([optionValue.key isEqualToString:OPTION_VALUE_PASTEBOARD]) {
            [self pasteboardOptionValueForOption:option];
        } else if([optionValue.key isEqualToString:OPTION_VALUE_CAMERA_ROLL]) {
            [self lastPhotoOptionValueForOption:option];
        }
    } else {
        // Value is already there, don't need to wait for compiling, set it now
        [self setCompiledValue:compiledValue forOption:option];
    }
}

- (void)setCompiledValue:(id)compiledValue forOption:(LLOptionPrototype *)option {
    //@TODO do we need this? probably should be handled by each command
    if (option.dataType == DATA_ARRAY && [compiledValue isKindOfClass:[NSString class]]) {
        compiledValue = [compiledValue componentsSeparatedByString:COMPONENTS_SEPARATOR];
    }
    [self.compilingCommand setValue:compiledValue forKey:option.key];
    [self decreaseCompilingCounter];
}

- (void)pasteboardOptionValueForOption:(LLOptionPrototype *)option {
    // TODO: support different type (images, colors, data)
    UIPasteboard *pastebboard = [UIPasteboard generalPasteboard];
    [self setCompiledValue:pastebboard.string forOption:option];
}

- (void)lastPhotoOptionValueForOption:(LLOptionPrototype *)option {
    
}

@end

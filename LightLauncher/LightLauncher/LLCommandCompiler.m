//
//  LLCommandCompiler.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import "LLCommandCompiler.h"
#import "LLCommandFactory.h"
#import "LLCommand.h"
#import "LLCommandPrototype.h"
#import "LLOptionPrototype.h"
#import "LLOptionValuePrototype.h"

@interface LLCommandCompiler ()
- (void)decreaseCompilingCounter;
- (void)doneCompiling;
- (void)cleanUpAfterCompiling;
- (void)compileValueForOption:(LLOptionPrototype *)option fromOptionValuePrototype:(LLOptionValuePrototype *)optionValue;
- (void)setCompiledValue:(id)compiledValue forOption:(LLOptionPrototype *)option;
- (void)onFailedCompilingValueForOption:(LLOptionPrototype *)option withError:(NSError *)error;
- (void)pasteboardOptionValueForOption:(LLOptionPrototype *)option;
- (void)lastPhotoOptionValueForOption:(LLOptionPrototype *)option;
@end

@implementation LLCommandCompiler

- (void)decreaseCompilingCounter {
    BOOL done;
    
    @synchronized(self) {
        self.compilingCounter--;
        done = self.compilingCounter <= 0;
    }
    
    if (done) {
        [self doneCompiling];
    }
}

- (void)doneCompiling {
    [self.delegate onFinishedCompilingCommandPrototype:self.compilingCommandPrototype withCompiledValue:self.compilingCommand];
    [self cleanUpAfterCompiling];
}

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
                if (option.dataType != DATA_ARRAY) {
                    continue;
                }
            }
        }
    }
    
    if (self.compilingCounter == 0) {
        [self doneCompiling];
        return;
    }

    for (LLOptionPrototype *option in commandPrototype.options) {
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            if (optionValue.selected) {
                [self compileValueForOption:option fromOptionValuePrototype:optionValue];
                if (option.dataType != DATA_ARRAY) {
                    continue;
                }
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
        } else if([optionValue.key isEqualToString:OPTION_VALUE_SERVICE_TYPE_FACEBOOK]) {
            [self setCompiledValue:OPTION_VALUE_SERVICE_TYPE_FACEBOOK forOption:option];
        } else if([optionValue.key isEqualToString:OPTION_VALUE_SERVICE_TYPE_TWITTER]) {
            [self setCompiledValue:OPTION_VALUE_SERVICE_TYPE_FACEBOOK forOption:option];
        } else if ([option.key isEqualToString:OPTION_VALUE_SERVICE_TYPE_GOOGLE_PLUS]) {
            [self setCompiledValue:OPTION_VALUE_SERVICE_TYPE_GOOGLE_PLUS forOption:option];
        }
    } else {
        // Value is already there, don't need to wait for compiling, set it now
        [self setCompiledValue:compiledValue forOption:option];
    }
}

- (void)setCompiledValue:(id)compiledValue forOption:(LLOptionPrototype *)option {
    [self.compilingCommand setValue:compiledValue forKey:option.key];
    [self decreaseCompilingCounter];
}

- (void)onFailedCompilingValueForOption:(LLOptionPrototype *)option withError:(NSError *)error {
    [self.delegate onFailedCompilingCommandPrototype:self.compilingCommandPrototype withError:error];
    // Still call decrease, so that onFinishedCompilingCommandPrototype:withCompiledValue is still called if the counter reaches 0, because we want to ignore any failure.
    [self decreaseCompilingCounter];
}

- (void)pasteboardOptionValueForOption:(LLOptionPrototype *)option {
    // TODO: support different type (images, colors, data)
    UIPasteboard *pastebboard = [UIPasteboard generalPasteboard];
    [self setCompiledValue:pastebboard.string forOption:option];
}

- (void)lastPhotoOptionValueForOption:(LLOptionPrototype *)option {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    //Enumerate just saved photos and videos group
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        // Within the group, get all photos
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        
        // Last photo is the one has the last index
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:([group numberOfAssets] - 1)];
        [group enumerateAssetsAtIndexes:indexes options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            // The end of enumeration is a null asset
            UIImage *image;
            if (result) {
                ALAssetRepresentation *representation = [result defaultRepresentation];
                image = [UIImage imageWithCGImage:[representation fullScreenImage]];
            }
            
            //@TODO: may handle error when image can't be loaded.
            [self setCompiledValue:image forOption:option];
        }];
    } failureBlock:^(NSError *error) {
        [self onFailedCompilingValueForOption:option withError:error];
    }];
}

@end

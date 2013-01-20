//
//  LLCommandCompiler.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>

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
- (void)compileValueFromOptionValuePrototype:(LLOptionValuePrototype *)optionValue;
- (void)setCompiledValue:(id)compiledValue;
- (void)onFailedCompilingValueWithError:(NSError *)error;
- (void)pasteboardOptionValue;
- (void)lastPhotoOptionValue;
- (void)pickPhotoOptionValue;
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
    self.compilingOption = nil;
    self.delegate = nil;
    self.viewController = nil;
}

- (void)compile:(LLCommandPrototype *)commandPrototype withDelegate:(id<LLCommandCompilerDelegate>)delegate andViewController:(UIViewController *)viewController {
    self.delegate = delegate;
    self.viewController = viewController;
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
        self.compilingOption = option;
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            if (optionValue.selected) {
                [self compileValueFromOptionValuePrototype:optionValue];
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
}

- (void)compileValueFromOptionValuePrototype:(LLOptionValuePrototype *)optionValue {
    id compiledValue = optionValue.value;
    
    if (!compiledValue) {
        // If value is nil, it needs to be got at runtime.
        // Check and get it now
        if ([optionValue.key isEqualToString:OPTION_VALUE_PASTEBOARD]) {
            [self pasteboardOptionValue];
        } else if ([optionValue.key isEqualToString:OPTION_VALUE_CAMERA_ROLL]) {
            [self lastPhotoOptionValue];
        } else if ([optionValue.key isEqualToString:OPTION_VALUE_IMAGE_PICK_LATER]) {
            [self pickPhotoOptionValue];
        } else if([optionValue.key isEqualToString:OPTION_VALUE_SERVICE_TYPE_FACEBOOK]) {
            [self setCompiledValue:OPTION_VALUE_SERVICE_TYPE_FACEBOOK];
        } else if([optionValue.key isEqualToString:OPTION_VALUE_SERVICE_TYPE_TWITTER]) {
            [self setCompiledValue:OPTION_VALUE_SERVICE_TYPE_TWITTER];
        } else if ([optionValue.key isEqualToString:OPTION_VALUE_SERVICE_TYPE_GOOGLE_PLUS]) {
            [self setCompiledValue:OPTION_VALUE_SERVICE_TYPE_GOOGLE_PLUS];
        }
    } else {
        // Value is already there, don't need to wait for compiling, set it now
        [self setCompiledValue:compiledValue];
    }
}

- (void)setCompiledValue:(id)compiledValue {
    [self.compilingCommand setValue:compiledValue forKey:self.compilingOption.key];
    [self decreaseCompilingCounter];
}

- (void)onFailedCompilingValueWithError:(NSError *)error {
    [self.delegate onFailedCompilingCommandPrototype:self.compilingCommandPrototype withError:error];
    // Still call decrease, so that onFinishedCompilingCommandPrototype:withCompiledValue is still called if the counter reaches 0, because we want to ignore any failure.
    [self decreaseCompilingCounter];
}

- (void)pasteboardOptionValue {
    // TODO: support different type (images, colors, data)
    UIPasteboard *pastebboard = [UIPasteboard generalPasteboard];
    [self setCompiledValue:pastebboard.string];
}

- (void)lastPhotoOptionValue {
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
            [self setCompiledValue:image];
        }];
    } failureBlock:^(NSError *error) {
        [self onFailedCompilingValueWithError:error];
    }];
}

#pragma mark - Pick image using UIImagePickerController

- (void)pickPhotoOptionValue {
    NSError *error;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        error = [NSError errorWithDomain:ERROR_DOMAIN code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Photo library is not available", NSLocalizedDescriptionKey, nil]];
    }
    if (!self.viewController) {
        error = [NSError errorWithDomain:ERROR_DOMAIN code:2 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"ViewController is not available", NSLocalizedDescriptionKey, nil]];
    }
    if (error) {
        [self onFailedCompilingValueWithError:error];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // Only interested in image
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = self;
    
    [self.viewController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Image Picker Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    
    //@TODO may add cancel callback to delegate
     NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:2 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Canceled", NSLocalizedDescriptionKey, nil]];
    [self onFailedCompilingValueWithError:error];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    [self setCompiledValue:image];
}


@end

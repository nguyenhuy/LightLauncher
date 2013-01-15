//
//  LLGooglePlusCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/15/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLGooglePlusCommand.h"
#import "LLAppDelegate.h"

@implementation LLGooglePlusCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_URL]) {
        if ([value isKindOfClass:[NSURL class]]) {
            self.url = value;
        } else if ([value isKindOfClass:[NSString class]]) {
            //@TODO may check if the url is malformed.
            self.url = [NSURL URLWithString:value];
        }
    } else if ([key isEqualToString:OPTION_BODY] && [value isKindOfClass:[NSString class]]) {
        self.body = value;
    }
}

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    [super executeWithViewController:viewController withCommandDelegate:delegate];
    
    LLAppDelegate *appDelegate = [LLAppDelegate sharedInstance];
    [appDelegate ensureGppShare];
    
    appDelegate.share.delegate = self;
    [[[[appDelegate.share shareDialog] setPrefillText:self.body] setURLToShare:self.url] open];
}

- (void)cleanUpAfterExecuting {
    [super cleanUpAfterExecuting];
    
    LLAppDelegate *appDelegate = [LLAppDelegate sharedInstance];
    appDelegate.share.delegate = nil;
    appDelegate.share = nil;
}

#pragma mark Google Plust Share Delegate

- (void)finishedSharing:(BOOL)shared {
    if (shared) {
        [self onFinished];
    } else {
        [self onCanceled];
    }
}

@end

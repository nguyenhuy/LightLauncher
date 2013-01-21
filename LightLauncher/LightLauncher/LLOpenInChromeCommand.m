//
//  LLOpenInChromeCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/21/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLOpenInChromeCommand.h"
#import "OpenInChromeController.h"

@implementation LLOpenInChromeCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_URL]) {
        if ([value isKindOfClass:[NSURL class]]) {
            self.url = value;
        } else if ([value isKindOfClass:[NSString class]]) {
            self.url = [NSURL URLWithString:value];
        }
    } else if ([key isEqualToString:OPTION_CREATE_NEW_TAB]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            self.createNewTab = [value boolValue];
        }
    }
}

#pragma mark - Service command protocol

- (BOOL)isServiceAvailable {
    return [[OpenInChromeController sharedInstance] isChromeInstalled];
}

//@TODO may only show compose view controller of the url is empty
- (UIViewController *)constructComposeViewContrroller {
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"Open In Chrome";
    composeViewController.text = [self.url absoluteString];
    composeViewController.delegate = self;
    //@TODO change title of "Post" button to something else, "Go" for example.
    
    return composeViewController;
}

#pragma mark - REComposeViewControllerDelegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result {
    if (result == REComposeResultPosted) {
        self.url = [NSURL URLWithString:composeViewController.text];
        if (self.url) {
            //@TODO callback???
            [[OpenInChromeController sharedInstance] openInChrome:self.url withCallbackURL:nil createNewTab:self.createNewTab];
        } else {
            // The url is malformed or empty
            [self onErrorWithTitle:@"Error" andDesc:@"Invalid URL"];
        }
    } else {
        [self onCanceled];
    }
}

@end

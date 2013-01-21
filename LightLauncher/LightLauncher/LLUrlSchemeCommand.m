//
//  LLUrlSchemeCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/22/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLUrlSchemeCommand.h"

@implementation LLUrlSchemeCommand

- (NSString *)title {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"title must be implemented" userInfo:nil];
}

- (NSURL *)constructUrl {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"constructUrl must be implemented" userInfo:nil];
}

#pragma mark - Service command protocol

- (BOOL)isServiceAvailable {
    return YES;
}

- (UIViewController *)constructComposeViewContrroller {
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = self.title;
    composeViewController.text = [[self constructUrl] absoluteString];
    composeViewController.delegate = self;
    //@TODO change title of "Post" button to something else, "Go" for example.
    
    return composeViewController;
}

#pragma mark - REComposeViewControllerDelegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result {
    if (result == REComposeResultPosted) {
        NSURL *url = [NSURL URLWithString:composeViewController.text];
        if (url) {
            //@TODO callback???
            BOOL opened = [[UIApplication sharedApplication] openURL:url];
            if (opened) {
                [self onFinished];
            } else {
                [self onErrorWithTitle:@"Error" andDesc:@"Can't execute the URL Scheme"];
            }
        } else {
            // The url is malformed or empty
            [self onErrorWithTitle:@"Error" andDesc:@"Invalid URL Scheme"];
        }
    } else {
        [self onCanceled];
    }
}

@end

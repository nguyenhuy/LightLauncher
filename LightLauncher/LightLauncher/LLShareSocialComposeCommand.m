//
//  LLShareSocialComposeCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/16/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLShareSocialComposeCommand.h"

@implementation LLShareSocialComposeCommand

- (BOOL)isServiceAvailable {
    return [SLComposeViewController isAvailableForServiceType:[self serviceType]];
}

- (UIViewController *)constructComposeViewContrroller {
    SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:[self serviceType]];
    if (composeViewController == nil) {
        return nil;
    }
    
    [composeViewController setInitialText:self.body];
    [composeViewController addImage:self.image];
    [composeViewController addURL:self.url];
    
    [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    [self onCanceled];
                    break;
                case SLComposeViewControllerResultDone:
                    [self onFinished];
                    break;
            }            
        });
    }];
    
    return composeViewController;
}

@end

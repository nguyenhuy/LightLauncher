//
//  LLSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"
#import "LLBodyOption.h"
#import "LLUrlOption.h"
#import "LLImageOption.h"

@interface LLSocialCommand ()
- (void)addAllImageToComposeViewController:(SLComposeViewController *) composeViewController;
- (void)addAllUrlsToComposeViewController:(SLComposeViewController *) composeViewController;
@end

@implementation LLSocialCommand

- (NSString *)serviceType {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"serviceType must be implemented" userInfo:nil];
}

- (BOOL)isServiceAvailable {
    return [SLComposeViewController isAvailableForServiceType:[self serviceType]];
}

- (BOOL)isFinishedAfterPresentingComposeViewController {
    return NO;
}

- (UIViewController *)composeViewController {
    SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:[self serviceType]];
    if (composeViewController == nil) {
        return nil;
    }
    
    [composeViewController setInitialText:self.bodyOption.param];
    [self addAllImageToComposeViewController:composeViewController];
    [self addAllUrlsToComposeViewController:composeViewController];
    
    [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *message;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                message = @"Canceled";
                break;
            case SLComposeViewControllerResultDone:
                message = @"Done";
        }
        [self onFinishedWithStatusTitle:[self serviceName] andMessage:message];
    }];
    
    return composeViewController;
}

- (void)addAllImageToComposeViewController:(SLComposeViewController *)composeViewController {
    for(LLImageOption *imageOption in self.imageOptions) {
        [composeViewController addImage:imageOption.image];
    }
}

- (void)addAllUrlsToComposeViewController:(SLComposeViewController *)composeViewController {
    for (LLUrlOption *urlOption in self.urlOptions) {
        [composeViewController addURL:urlOption.url];
    }
}

@end

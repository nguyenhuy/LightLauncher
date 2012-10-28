//
//  LLSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"

@interface LLSocialCommand ()
- (void)addAllImageToComposeViewController:(SLComposeViewController *) composeViewController;
- (void)addAllUrlsToComposeViewController:(SLComposeViewController *) composeViewController;
@end

@implementation LLSocialCommand

#pragma mark - Getters and Setters

- (NSString *)body {
    return [self valueForKey:OPTION_BODY];
}

- (NSArray *)urls {
    return [self valueForKey:OPTION_URLS];
}

- (NSArray *)images {
    return [self valueForKey:OPTION_IMAGES];
}

- (void)setBody:(NSString *)body {
    [self setValue:body forKey:OPTION_BODY];
}

- (void)addUrl:(NSString *)url {
    [self addValue:url forKey:OPTION_URLS];
}

- (void)addImage:(NSString *)path {
    [self addValue:path forKey:OPTION_IMAGES];
}

#pragma mark - Service methods

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
    
    [composeViewController setInitialText:self.body];
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
    for(NSString *path in self.images) {
        [composeViewController addImage:[UIImage imageNamed:path]];
    }
}

- (void)addAllUrlsToComposeViewController:(SLComposeViewController *)composeViewController {
    for (NSString *url in self.urls) {
        [composeViewController addURL:[NSURL URLWithString:url]];
    }
}

@end

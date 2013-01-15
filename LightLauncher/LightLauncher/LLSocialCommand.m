//
//  LLSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"

@interface LLSocialCommand ()
@end

@implementation LLSocialCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_BODY] && [value isKindOfClass:[NSString class]]) {
        self.body = value;
    } else if ([key isEqualToString:OPTION_URL]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.url = [NSURL URLWithString:value];
        } else if ([value isKindOfClass:[NSURL class]]) {
            self.url = value;
        }
    } else if ([key isEqualToString:OPTION_IMAGE] && [value isKindOfClass:[UIImage class]]) {
        self.image = value;
    } else {
        [super setValue:value forKey:key];
    }
}

#pragma mark - Service methods

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
        //@TODO: Note that completion handlers are not called on any particular thread.
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                [self onCanceled];
                break;
            case SLComposeViewControllerResultDone:
                [self onFinished];
                break;
        }
    }];
    
    return composeViewController;
}

@end

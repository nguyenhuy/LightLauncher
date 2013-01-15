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

- (id)init {
    self = [super init];
    if (self) {
        self.urls = [[NSMutableArray alloc] init];
        self.images = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_BODY] && [value isKindOfClass:[NSString class]]) {
        self.body = value;
    } else if ([key isEqualToString:OPTION_URLS]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self.urls addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.urls addObjectsFromArray:value];
        }
    } else if ([key isEqualToString:OPTION_IMAGE_ATTACHMENTS]) {
        if ([value isKindOfClass:[UIImage class]]) {
            [self.images addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.images addObjectsFromArray:value];
        }
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
    [self addAllImageToComposeViewController:composeViewController];
    [self addAllUrlsToComposeViewController:composeViewController];
    
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

- (void)addAllImageToComposeViewController:(SLComposeViewController *)composeViewController {
    for(UIImage *image in self.images) {
        [composeViewController addImage:image];
    }
}

- (void)addAllUrlsToComposeViewController:(SLComposeViewController *)composeViewController {
    for (NSURL *url in self.urls) {
        [composeViewController addURL:url];
    }
}

@end

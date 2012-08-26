//
//  LLTwitterCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLTwitterCommand.h"
#import <Twitter/Twitter.h>

@implementation LLTwitterCommand

- (NSString *)description {
    return @"Twitter";
}

- (NSString *)iconFileName {
    return @"twitter.png";
}

- (void) executeFromViewController:(UIViewController *)viewController {
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *controller = [[TWTweetComposeViewController alloc] init];
        [controller setInitialText:@"Test LightLauncher"];
        [viewController presentModalViewController:controller animated:YES];
    } else {
#warning warm user
    }
}

@end
//
//  LLTwitterCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Twitter/Twitter.h>
#import "LLTwitterCommand.h"
#import "LLBodyOption.h"
#import "LLUrlOption.h"
#import "LLImageOption.h"

@implementation LLTwitterCommand

@synthesize bodyOption = _bodyOption;
@synthesize urlOption = _urlOption;
@synthesize imageOption = _imageOption;

- (NSString *)description {
    return @"Twitter";
}

- (NSString *)iconFileName {
    return @"twitter.png";
}

- (void) executeFromViewController:(UIViewController *)viewController {
    TWTweetComposeViewController *controller = [[TWTweetComposeViewController alloc] init];
    [controller setInitialText:self.bodyOption.param];
    [controller addURL:[NSURL URLWithString:self.urlOption.param]];
    [controller addImage:self.imageOption.image];
    [viewController presentModalViewController:controller animated:YES];
    
    controller.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        NSString *title = @"status";
        NSString *msg;
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"Tweet compostion was canceled.";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweet composition completed.";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [viewController dismissModalViewControllerAnimated:YES];
    };
}

@end
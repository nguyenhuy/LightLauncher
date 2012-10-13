//
//  LLSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"

@implementation LLSocialCommand

- (NSString *)serviceType {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"serviceType must be implemented" userInfo:nil];
}

- (void) executeFromViewController:(UIViewController *)viewController {
    
    
    TWTweetComposeViewController *controller = [[TWTweetComposeViewController alloc] init];
    [controller setInitialText:self.bodyOption.param];
    [controller addURL:[NSURL URLWithString:self.urlOption.param]];
    [controller addImage:self.imageOption.image];
    [viewController presentViewController:controller animated:YES completion:nil];
    
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
        [viewController dismissViewControllerAnimated:YES completion:nil];
    };
}

@end

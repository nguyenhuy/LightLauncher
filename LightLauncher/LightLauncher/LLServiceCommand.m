//
//  LLViewControllerCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/14/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLServiceCommand.h"

@implementation LLServiceCommand

- (NSString *)serviceName {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"serviceName must be implemented" userInfo:nil];
}

- (BOOL)isServiceAvailable {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"isServiceAvailable must be implemented" userInfo:nil];
}

- (UIViewController *)composeViewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"composeViewController must be implemented" userInfo:nil];
}

- (BOOL)isFinishedAfterPresentingComposeViewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"isFinishedAfterPresentingComposeViewController must be implemented" userInfo:nil];
}

- (void)executeFromViewController:(UIViewController *)viewController {
    self.viewController = viewController;
    UIViewController *composeViewController;
    
    if (![self isServiceAvailable]
        || (composeViewController = [self composeViewController]) == nil) {
        [self onServiceNotAvailable];
    } else {
        [self.viewController presentViewController:composeViewController animated:YES completion:^() {
            if ([self isFinishedAfterPresentingComposeViewController]) {
                [self onFinishedWithStatusTitle:[self serviceName] andMessage:@"Finished"];
            }
        }];
    }
}

- (void)onFinishedWithStatusTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    if (self.viewController != nil) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
        self.viewController = nil;
    }
}

- (void)onServiceNotAvailable {
    NSString *title = [NSString stringWithFormat:@"%@ not available", [self serviceName]];
    [self onFinishedWithStatusTitle:title andMessage:@"Please check your Settings"];
}

@end

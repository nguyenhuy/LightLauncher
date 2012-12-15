//
//  LLViewControllerCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/14/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLServiceCommand.h"

@interface LLServiceCommand ()
- (void)setServiceType:(NSString *)serviceType;
- (void)setServiceName:(NSString *)serviceName;
@end

@implementation LLServiceCommand

- (id)initWithServiceType:(NSString *)serviceType andServiceName:(NSString *)serviceName {
    self = [super init];
    if (self) {
        self.serviceType = serviceType;
        self.serviceName = serviceName;
    }
    return self;
}

#pragma mark - Getters and Setters

- (NSString *)serviceType {
    return [self valueForKey:OPTION_SERVICE_TYPE];
}

- (NSString *)serviceName {
    return [self valueForKey:OPTION_SERVICE_NAME];
}

- (void)setServiceType:(NSString *)serviceType {
    [self setValue:serviceType forKey:OPTION_SERVICE_TYPE];
}

- (void)setServiceName:(NSString *)serviceName {
    [self setValue:serviceName forKey:OPTION_SERVICE_NAME];
}

#pragma mark - Service related methods

- (BOOL)isServiceAvailable {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"isServiceAvailable must be implemented" userInfo:nil];
}

- (UIViewController *)constructComposeViewContrroller {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"constructComposeViewContrroller must be implemented" userInfo:nil];
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
    
    if (self.viewController) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
        self.viewController = nil;
    }
    if (self.composeViewController) {
        self.composeViewController = nil;
    }
}

- (void)onServiceNotAvailable {
    NSString *title = [NSString stringWithFormat:@"%@ not available", [self serviceName]];
    [self onFinishedWithStatusTitle:title andMessage:@"Please check your Settings"];
}

@end

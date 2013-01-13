//
//  LLViewControllerCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/14/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLServiceCommand.h"

@interface LLServiceCommand ()
@end

@implementation LLServiceCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_SERVICE_NAME] && [value isKindOfClass:[NSString class]]) {
        self.serviceName = value;
    } else if ([key isEqualToString:OPTION_SERVICE_TYPE] && [value isKindOfClass:[NSString class]]) {
        self.serviceType = value;
    } else {
        [super setValue:value forKey:key];
    }
}

#pragma mark - Service related methods

- (BOOL)isServiceAvailable {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"isServiceAvailable must be implemented" userInfo:nil];
}

- (UIViewController *)constructComposeViewContrroller {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"constructComposeViewContrroller must be implemented" userInfo:nil];
}

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    [super executeWithViewController:viewController withCommandDelegate:delegate];
    self.viewController = viewController;
    UIViewController *composeViewController = [self constructComposeViewContrroller];
    
    if (![self isServiceAvailable] || !composeViewController) {
        [self onServiceNotAvailable];
    } else {
        [viewController presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)onFinished {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    self.viewController = nil;

    [super onFinished];
}

- (void)onCanceled {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    self.viewController = nil;

    [super onCanceled];
}

- (void)onErrorWithTitle:(NSString *)title andDesc:(NSString *)desc {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    self.viewController = nil;
    
    [super onErrorWithTitle:title andDesc:desc];
}

- (void)onServiceNotAvailable {
    NSString *title = [NSString stringWithFormat:@"%@ not available", [self serviceName]];
    [self onErrorWithTitle:title andDesc:@"Please check your Settings"];
}

@end

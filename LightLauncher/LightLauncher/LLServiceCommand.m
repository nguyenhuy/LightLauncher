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

- (void)onFinishedWithStatusTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    self.viewController = nil;
    
    // We should call this lastly, since it will unbind this command in CommandManager
    // and this command will be collected shortly
    [super onFinished];
}

- (void)onServiceNotAvailable {
    NSString *title = [NSString stringWithFormat:@"%@ not available", [self serviceName]];
    [self onFinishedWithStatusTitle:title andMessage:@"Please check your Settings"];
}

@end

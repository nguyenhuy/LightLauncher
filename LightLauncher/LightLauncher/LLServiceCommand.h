//
//  LLViewControllerCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/14/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@interface LLServiceCommand : LLCommand

@property (nonatomic, strong) UIViewController *viewController;

// Service type is the identifier of a service, might be used to pass to Social.framework (ie: FB and Twitter). So this should be unique
// Service name is human readbale, will be showed in UI.
- (id)initWithServiceType:(NSString *)serviceType andServiceName:(NSString *)serviceName;
- (NSString *)serviceType;
- (NSString *)serviceName;
- (BOOL)isServiceAvailable;
- (BOOL)isFinishedAfterPresentingComposeViewController;
- (UIViewController *)composeViewController;
- (void)onFinishedWithStatusTitle:(NSString *)title andMessage:(NSString *)message;
- (void)onServiceNotAvailable;

@end

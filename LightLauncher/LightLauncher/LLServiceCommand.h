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

- (NSString *)serviceName;
- (BOOL)isServiceAvailable;
- (BOOL)isFinishedAfterPresentingComposeViewController;
- (UIViewController *)composeViewController;
- (void)onFinishedWithStatusTitle:(NSString *)title andMessage:(NSString *)message;
- (void)onServiceNotAvailable;

@end

//
//  LLViewControllerCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/14/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@protocol LLServiceCommandProtocol <NSObject>

- (BOOL)isServiceAvailable;
- (UIViewController *)constructComposeViewContrroller;

@end

@interface LLServiceCommand : LLCommand <LLServiceCommandProtocol>

// Service type is the identifier of a service, might be used to pass to Social.framework (ie: FB and Twitter). So this should be unique
// Service name is human readbale, will be showed in UI.
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *serviceType;

- (void)onServiceNotAvailable;

@end

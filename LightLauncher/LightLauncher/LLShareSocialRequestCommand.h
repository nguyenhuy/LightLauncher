//
//  LLShareFacebookRequestCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/16/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

// Command that share to social networks via SLRequest of Social.framework.
// Used when there is a common compose view controller for multiple services (like MultipleSocialsCommand).
// This shouldn't be exposed directly to user.
// If only share to Facebook/Twitter, consider using LLShareSocialComposeCommand.
@interface LLShareSocialRequestCommand : LLCommand

@property (nonatomic, strong) NSString *serviceType;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image;

@end

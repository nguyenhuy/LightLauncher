//
//  LLSocialCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Social/Social.h>
#import "LLServiceCommand.h"

// Command that shares to social networks via SLComposeViewController of Social.framework.
@interface LLSocialCommand : LLServiceCommand

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image;

@end

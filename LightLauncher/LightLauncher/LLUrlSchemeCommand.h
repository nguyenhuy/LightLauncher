//
//  LLUrlSchemeCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/22/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLServiceCommand.h"
#import "REComposeViewController.h"

@interface LLUrlSchemeCommand : LLServiceCommand <REComposeViewControllerDelegate>

//@TODO Support callback maybe?

- (NSString *)title;
- (NSURL *)constructUrl;

@end

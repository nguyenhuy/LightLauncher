//
//  LLUrlSchemeCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/22/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@interface LLUrlSchemeCommand : LLCommand

//@TODO Support callback maybe?
//@TODO check service available

// Methods that need to be implemented by subclasses.
- (NSString *)title;
// The root of URL Scheme to be opened. Used to check if the app is available/installed.
- (NSURL *)urlScheme;
// Constructs a full URL that will be opened.
- (NSURL *)constructUrl;

// Methods that are implemented. If this method is overriden, "urlScheme:" may not needed to be overriden.
- (BOOL)isAppInstalled;

@end

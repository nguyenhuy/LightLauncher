//
//  LLSocialCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Social/Social.h>
#import "LLServiceCommand.h"

@interface LLSocialCommand : LLServiceCommand

@property (nonatomic, strong) NSString *body;
// Array of NSURLs
@property (nonatomic, strong) NSMutableArray *urls;
// Array of UIImages
@property (nonatomic, strong) NSMutableArray *images;

@end

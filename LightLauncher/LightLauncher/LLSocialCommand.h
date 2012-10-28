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

- (NSString *)body;
- (NSArray *)urls;
- (NSArray *)images;

- (void)setBody:(NSString *)body;
- (void)addUrl:(NSString *)url;
- (void)addImage:(NSString *)path;

@end

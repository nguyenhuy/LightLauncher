//
//  LLSocialCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Social/Social.h>
#import "LLServiceCommand.h"

@class LLBodyOption;

@interface LLSocialCommand : LLServiceCommand

@property (nonatomic, strong) LLBodyOption *bodyOption;
@property (nonatomic, strong) NSArray *urlOptions;
@property (nonatomic, strong) NSArray *imageOptions;

@end

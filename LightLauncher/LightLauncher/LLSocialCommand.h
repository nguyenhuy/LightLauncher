//
//  LLSocialCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Social/Social.h>
#import "LLCommand.h"

@class LLImageOption;
@class LLUrlOption;
@class LLBodyOption;

@interface LLSocialCommand : LLCommand

@property (nonatomic, strong) LLBodyOption *bodyOption;
@property (nonatomic, strong) LLUrlOption *urlOption;
@property (nonatomic, strong) LLImageOption *imageOption;

- (NSString *) serviceType;

@end

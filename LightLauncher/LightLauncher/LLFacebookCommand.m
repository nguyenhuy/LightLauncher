//
//  LLFacebookCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFacebookCommand.h"

@implementation LLFacebookCommand

- (id)init {
    self = [super initWithServiceType:SLServiceTypeFacebook andServiceName:@"Facebook"];
    return self;
}

- (NSString *)command {
    return COMMAND_FACEBOOK;
}

- (NSString *)description {
    return @"Facebook";
}

- (NSString *)iconFileName {
    return @"facebook.png";
}

@end

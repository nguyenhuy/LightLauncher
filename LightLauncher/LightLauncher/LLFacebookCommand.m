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
    self = [super init];
    if (self) {
        self.serviceType = SLServiceTypeFacebook;
        self.serviceName = @"Facebook";
    }
    return self;
}

@end

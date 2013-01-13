//
//  LLTwitterCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLTwitterCommand.h"

@implementation LLTwitterCommand

- (id)init {
    self = [super init];
    if (self) {
        self.serviceType = SLServiceTypeTwitter;
        self.serviceName = @"Twitter";
    }
    return self;
}

@end
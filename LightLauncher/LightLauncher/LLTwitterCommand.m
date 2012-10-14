//
//  LLTwitterCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLTwitterCommand.h"

@implementation LLTwitterCommand

- (NSString *)serviceName {
    return @"Twitter";
}

- (NSString *)serviceType {
    return SLServiceTypeTwitter;
}

- (NSString *)description {
    return @"Twitter";
}

- (NSString *)iconFileName {
    return @"twitter.png";
}

@end
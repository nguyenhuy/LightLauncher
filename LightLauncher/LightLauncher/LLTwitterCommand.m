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
    self = [super initWithServiceType:SLServiceTypeTwitter andServiceName:@"Twitter"];
    return self;
}

#pragma mark - Command methods

+ (LLCommand *)commandPrototype {
    LLTwitterCommand *instance = [[LLTwitterCommand alloc] init];
    instance.body = @"Hello Twitter";
    
    [instance addUrl:@"google.com"];
    [instance addUrl:@"facebook.com"];
    
    [instance addImage:@"twitter.com"];
    [instance addImage:@"facebook.com"];
    
    return instance;
}

+ (NSString *)command {
    return COMMAND_TWITTER;
}

+ (NSString *)description {
    return @"Twitter";
}

+ (NSString *)iconFileName {
    return @"twitter.png";
}

@end
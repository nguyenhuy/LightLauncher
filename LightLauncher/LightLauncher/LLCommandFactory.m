//
//  LLCommandFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/16/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandFactory.h"
#import "LLCommand.h"

#import "LLEmailCommand.h"
#import "LLFacebookCommand.h"
#import "LLTwitterCommand.h"

@implementation LLCommandFactory

+ (LLCommand *)commandForString:(NSString *)command {
    if ([command isEqualToString:COMMAND_EMAIL]) {
        return [[LLEmailCommand alloc] init];
    }
    if ([command isEqualToString:COMMAND_FACEBOOK]) {
        return [[LLFacebookCommand alloc] init];
    }
    if([command isEqualToString:COMMAND_TWITTER]) {
        return [[LLTwitterCommand alloc] init];
    }
    return nil;
}

@end

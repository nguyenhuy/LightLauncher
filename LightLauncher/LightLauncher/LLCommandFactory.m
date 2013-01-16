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
#import "LLMultipleSocialsCommand.h"
#import "LLGooglePlusCommand.h"
#import "LLShareSocialComposeCommand.h"

@interface LLCommandFactory ()
+ (LLShareSocialComposeCommand *)shareSocialComposeCommandWithServiceType:(NSString *)serviceType andServiceName:(NSString *)serviceName;
@end

@implementation LLCommandFactory

+ (LLCommand *)commandForString:(NSString *)command {
    if ([command isEqualToString:COMMAND_EMAIL]) {
        return [[LLEmailCommand alloc] init];
    }
    if ([command isEqualToString:COMMAND_FACEBOOK]) {
        return [LLCommandFactory shareSocialComposeCommandWithServiceType:SLServiceTypeFacebook andServiceName:@"Facebook"];
    }
    if([command isEqualToString:COMMAND_TWITTER]) {
        return [LLCommandFactory shareSocialComposeCommandWithServiceType:SLServiceTypeTwitter andServiceName:@"Twitter"];
    }
    if ([command isEqualToString:COMMAND_MULTIPLE_SOCIALS]) {
        return [[LLMultipleSocialsCommand alloc] init];
    }
    if ([command isEqualToString:COMMAND_GOOGLE_PLUS]) {
        return [[LLGooglePlusCommand alloc] init];
    }
    return nil;
}

+ (LLShareSocialComposeCommand *)shareSocialComposeCommandWithServiceType:(NSString *)serviceType andServiceName:(NSString *)serviceName {
    LLShareSocialComposeCommand *command = [[LLShareSocialComposeCommand alloc] init];
    command.serviceType = serviceType;
    command.serviceName = serviceName;
    return command;
}

@end

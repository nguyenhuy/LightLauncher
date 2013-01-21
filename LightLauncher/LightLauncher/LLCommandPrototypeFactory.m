//
//  LLCommandPrototypeFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandPrototypeFactory.h"
#import "LLCommandPrototype.h"
#import "LLOptionPrototypeFactory.h"
#import "LLOptionPrototype.h"
#import "LLEmailCommand.h"
#import "LLShareSocialComposeCommand.h"

@interface LLCommandPrototypeFactory ()
+ (LLCommandPrototype *)socialCommandPrototypeForCommand:(NSString *)command withDesc:(NSString *)desc andIconFileName:(NSString *)iconFileName;
@end

@implementation LLCommandPrototypeFactory

+ (LLCommandPrototype *)commandPrototypeForCommand:(NSString *)command {
    if ([command isEqualToString:COMMAND_EMAIL]) {
        return [self emailCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_FACEBOOK]) {
        return [self facebookCommandPrototype];
    }
    if([command isEqualToString:COMMAND_TWITTER]) {
        return [self twitterCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_MULTIPLE_SOCIALS]) {
        return [self multipleSocialsCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_GOOGLE_PLUS]) {
        return [self googlePlusCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_OPEN_IN_CHROME]) {
        return [self openInChromeCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_INSTAPAPER_ADD]) {
        return [self instapaperAddCommandPrototype];
    }
    return nil;
}

+ (LLCommandPrototype *)socialCommandPrototypeForCommand:(NSString *)command withDesc:(NSString *)desc andIconFileName:(NSString *)iconFileName {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory imageOptionPrototype],
                        [LLOptionPrototypeFactory urlOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:command andOptions:options andDesc:desc andIconFileName:iconFileName];
    return commandPrototype;
}

+ (LLCommandPrototype *)emailCommandPrototype {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory subjectOptionPrototype],
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory toAddressesOptionPrototype],
                        [LLOptionPrototypeFactory ccAddressesOptionPrototype],
                        [LLOptionPrototypeFactory bccAddressesOptionPrototype],
                        [LLOptionPrototypeFactory fileAttachmentsOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:COMMAND_EMAIL andOptions:options andDesc:@"Email" andIconFileName:IMAGE_MAIL];
    return commandPrototype;
}

+ (LLCommandPrototype *)facebookCommandPrototype {
    return [self socialCommandPrototypeForCommand:COMMAND_FACEBOOK withDesc:@"Facebook" andIconFileName:IMAGE_FACEBOOK];
}

+ (LLCommandPrototype *)twitterCommandPrototype {
    return [self socialCommandPrototypeForCommand:COMMAND_TWITTER withDesc:@"Twitter" andIconFileName:IMAGE_TWITTER];
}

+ (LLCommandPrototype *)multipleSocialsCommandPrototype {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory socialsOptionPrototype],
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory imageOptionPrototype],
                        [LLOptionPrototypeFactory urlOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:COMMAND_MULTIPLE_SOCIALS andOptions:options andDesc:@"Multiple Social Networks" andIconFileName:IMAGE_FACEBOOK];
    return commandPrototype;
}

+ (LLCommandPrototype *)googlePlusCommandPrototype {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory urlOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:COMMAND_GOOGLE_PLUS andOptions:options andDesc:@"Google Plus" andIconFileName:IMAGE_GOOGLE_PLUS];
    return commandPrototype;
}

+ (LLCommandPrototype *)openInChromeCommandPrototype {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory urlOptionPrototype],
                        [LLOptionPrototypeFactory createNewTabOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:COMMAND_OPEN_IN_CHROME andOptions:options andDesc:@"Open In Google Chrome" andIconFileName:IMAGE_GOOGLE_CHROME];
    return commandPrototype;
}

+ (LLCommandPrototype *)instapaperAddCommandPrototype {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory urlOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:COMMAND_INSTAPAPER_ADD andOptions:options andDesc:@"Add to Instapaper" andIconFileName:IMAGE_INSTAPAPER];
    return commandPrototype;
}

@end

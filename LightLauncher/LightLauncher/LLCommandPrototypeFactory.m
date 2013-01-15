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
#import "LLFacebookCommand.h"
#import "LLTwitterCommand.h"

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

@end

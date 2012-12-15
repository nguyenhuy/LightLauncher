//
//  LLCommandPrototypeFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandPrototypeFactory.h"
#import "Constants.h"
#import "LLCommandPrototype.h"
#import "LLOptionPrototypeFactory.h"
#import "LLOptionPrototype.h"
#import "LLEmailCommand.h"
#import "LLFacebookCommand.h"
#import "LLTwitterCommand.h"

@interface LLCommandPrototypeFactory ()
+ (LLCommandPrototype *)socialCommandPrototypeForCommand:(LLSocialCommand *)command;
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
    return nil;
}

+ (LLCommandPrototype *)socialCommandPrototypeForCommand:(LLSocialCommand *)command {
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory imageAttachmentsOptionPrototype],
                        [LLOptionPrototypeFactory urlAddressesOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:command andOptions:options];
    return commandPrototype;
}

+ (LLCommandPrototype *)emailCommandPrototype {
    LLEmailCommand *command = [[LLEmailCommand alloc] init];
    
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory subjectOptionPrototype],
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory toAddressesOptionPrototype],
                        [LLOptionPrototypeFactory ccAddressesOptionPrototype],
                        [LLOptionPrototypeFactory bccAddressesOptionPrototype],
                        [LLOptionPrototypeFactory fileAttachmentsOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:command andOptions:options];
    return commandPrototype;
}

+ (LLCommandPrototype *)facebookCommandPrototype {
    LLFacebookCommand *command = [[LLFacebookCommand alloc] init];
    return [self socialCommandPrototypeForCommand:command];
}

+ (LLCommandPrototype *)twitterCommandPrototype {
    LLTwitterCommand *command = [[LLTwitterCommand alloc] init];
    return [self socialCommandPrototypeForCommand:command];
}

@end

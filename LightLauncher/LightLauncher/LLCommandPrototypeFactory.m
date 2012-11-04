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

@implementation LLCommandPrototypeFactory

+ (LLCommandPrototype *)commandPrototypeForCommand:(NSString *)command {
    if ([command isEqualToString:COMMAND_EMAIL]) {
        return [self emailCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_FACEBOOK]) {
        return [self facebookCommandPrototype];
    }
    if ([command isEqualToString:COMMAND_TWITTER]) {
        return [self twitterCommandPrototype];
    }
    return nil;
}

+ (LLCommandPrototype *)emailCommandPrototype {
    LLEmailCommand *command = [[LLEmailCommand alloc] init];
    
    command.subject = @"hello";
    command.body = @"Hello LightLauncher";
    
    [command addToAddress:@"allforone1511@gmail.com"];
    [command addToAddress:@"allforone1511@gmail.com"];
    [command addToAddress:@"allforone1511@gmail.com"];
    
    [command addCcAddress:@"allforone1511@gmail.com"];
    [command addCcAddress:@"allforone1511@gmail.com"];
    [command addCcAddress:@"allforone1511@gmail.com"];
    
    [command addBccAddress:@"allforone1511@gmail.com"];
    [command addBccAddress:@"allforone1511@gmail.com"];
    [command addBccAddress:@"allforone1511@gmail.com"];
    
    [command addAttachment:@"mail.png"];
    [command addAttachment:@"mail.png"];
    [command addAttachment:@"mail.png"];
    
    NSArray *options = [[NSArray alloc] initWithObjects:
                        [LLOptionPrototypeFactory subjectOptionPrototype],
                        [LLOptionPrototypeFactory bodyOptionPrototype],
                        [LLOptionPrototypeFactory toAddressesOptionPrototype],
                        [LLOptionPrototypeFactory ccAddressesOptionPrototype],
                        [LLOptionPrototypeFactory bccAddressesOptionPrototype],
                        nil];
    
    LLCommandPrototype *commandPrototype = [[LLCommandPrototype alloc] initWithCommand:command andOptions:options];
    return commandPrototype;
}

+ (LLCommandPrototype *)facebookCommandPrototype {
    
}

+ (LLCommandPrototype *)twitterCommandPrototype {
    
}

@end

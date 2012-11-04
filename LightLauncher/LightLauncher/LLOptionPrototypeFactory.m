//
//  LLOptionPrototypeFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionPrototypeFactory.h"
#import "Constants.h"
#import "LLOptionPrototype.h"

@implementation LLOptionPrototypeFactory

+ (LLOptionPrototype *)optionPrototypeWithName:(NSString *)name {
    if ([name isEqualToString:OPTION_SUBJECT]) {
        return [self subjectOptionPrototype];
    }
    if ([name isEqualToString:OPTION_BODY]) {
        return [self bodyOptionPrototype];
    }
    if([name isEqualToString:OPTION_TO_ADDRESSES]) {
        return [self toAddressesOptionPrototype];
    }
    if([name isEqualToString:OPTION_CC_ADDRESSES]) {
        return [self ccAddressesOptionPrototype];
    }
    if([name isEqualToString:OPTION_BCC_ADDRESSES]) {
        return [self bccAddressesOptionPrototype];
    }
    if ([name isEqualToString:OPTION_ATTACHMENTS]) {
        return [self attachmentsOptionPrototype];
    }
    return nil;
}

+ (LLOptionPrototype *)optionPrototypeWithName:(NSString *)name andDisplayName:(NSString *)displayName andPossibleValue:(NSString *)possibleValue andDisplayPossibleValue:(NSString *)displayPossibleValue {
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    displayPossibleValue, possibleValue,
                                    nil];
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithName:name andDisplayName:displayName andPossibleValues:possibleValues];
    return optionPrototype;
}

+(LLOptionPrototype *)subjectOptionPrototype {
    return [self optionPrototypeWithName:OPTION_SUBJECT andDisplayName:@"Subject" andPossibleValue:@"" andDisplayPossibleValue:@""];
}

+ (LLOptionPrototype *)bodyOptionPrototype {
    NSString *subject = [NSString stringWithFormat:@"Send via %@", APP_NAME];
    return [self optionPrototypeWithName:OPTION_BODY andDisplayName:@"Body" andPossibleValue:subject andDisplayPossibleValue:subject];
}

+ (LLOptionPrototype *)toAddressesOptionPrototype {
    return [self optionPrototypeWithName:OPTION_TO_ADDRESSES andDisplayName:@"To" andPossibleValue:@"support@lightlauncher.com" andDisplayPossibleValue:@"support@lightlauncher.com"];
}

+ (LLOptionPrototype *)ccAddressesOptionPrototype {
    return [self optionPrototypeWithName:OPTION_CC_ADDRESSES andDisplayName:@"Cc" andPossibleValue:@"support@lightlauncher.com" andDisplayPossibleValue:@"support@lightlauncher.com"];
}

+ (LLOptionPrototype *)bccAddressesOptionPrototype {
    return [self optionPrototypeWithName:OPTION_BCC_ADDRESSES andDisplayName:@"Bcc" andPossibleValue:@"support@lightlauncher.com" andDisplayPossibleValue:@"support@lightlauncher.com"];
}

+ (LLOptionPrototype *)attachmentsOptionPrototype {
    return [self optionPrototypeWithName:OPTION_ATTACHMENTS andDisplayName:@"Attachments" andPossibleValue:@"mail.png" andDisplayPossibleValue:@"mail.png"];
}

@end

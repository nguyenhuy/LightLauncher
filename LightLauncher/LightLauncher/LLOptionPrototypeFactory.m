//
//  LLOptionPrototypeFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionPrototypeFactory.h"
#import "LLOptionValuePrototypeFactory.h"

#import "LLOptionPrototype.h"
#import "LLOptionValuePrototype.h"

#import "Constants.h"

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
    if ([name isEqualToString:OPTION_FILE_ATTACHMENTS]) {
        return [self fileAttachmentsOptionPrototype];
    }
    return nil;
}

+(LLOptionPrototype *)subjectOptionPrototype {
    LLOptionValuePrototype *prefillSubjectValue = [LLOptionValuePrototypeFactory stringOptionValuePrototypeWithDisplayName:@"Subject"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillSubjectValue.key, prefillSubjectValue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SUBJECT andDisplayName:@"Subject" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)bodyOptionPrototype {
    NSString *subject = [NSString stringWithFormat:@"Send via %@", APP_NAME];
    LLOptionValuePrototype *prefillBodyValue = [LLOptionValuePrototypeFactory stringOptionValuePrototypeWithDisplayName:subject];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillBodyValue.key, prefillBodyValue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BODY andDisplayName:@"Body" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)toAddressesOptionPrototype {
    LLOptionValuePrototype *prefillToValue = [LLOptionValuePrototypeFactory emailsOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillToValue.key, prefillToValue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_TO_ADDRESSES andDisplayName:@"To" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)ccAddressesOptionPrototype {
    LLOptionValuePrototype *prefillCcValue = [LLOptionValuePrototypeFactory emailsOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillCcValue.key, prefillCcValue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_CC_ADDRESSES andDisplayName:@"Cc" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)bccAddressesOptionPrototype {
    LLOptionValuePrototype *prefillBccValue = [LLOptionValuePrototypeFactory emailsOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillBccValue.key, prefillBccValue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BCC_ADDRESSES andDisplayName:@"Bcc" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)urlAddressesOptionPrototype {
    LLOptionValuePrototype *prefillUrlvalue = [LLOptionValuePrototypeFactory urlsOptionValuePrototypeWithDisplayName:@"http://lightlauncher.com"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillUrlvalue.key, prefillUrlvalue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_URLS andDisplayName:@"URLs" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)fileAttachmentsOptionPrototype {
    LLOptionValuePrototype *fileValue = [LLOptionValuePrototypeFactory fileAttachmentsOptionValuePrototypeWithDisplayName:@"Pick now"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    fileValue.key, fileValue,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_FILE_ATTACHMENTS andDisplayName:@"File attachments" andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)imageAttachmentsOptionPrototype {
    LLOptionValuePrototype *imageValue = [LLOptionValuePrototypeFactory imageAttachmentsOptionValuePrototypeWithDisplayName:@"Pick now"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    imageValue.key, imageValue,
                                    nil];

    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_IMAGE_ATTACHMENTS andDisplayName:@"Images" andPossibleValues:possibleValues];
    return optionPrototype;
}

@end

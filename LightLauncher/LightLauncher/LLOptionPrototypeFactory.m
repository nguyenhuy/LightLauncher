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
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillSubjectValue, prefillSubjectValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SUBJECT andDisplayName:@"Subject" andDataType:DATA_STRING andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)bodyOptionPrototype {
    NSString *subject = [NSString stringWithFormat:@"Send via %@", APP_NAME];
    LLOptionValuePrototype *prefillBodyValue = [LLOptionValuePrototypeFactory stringOptionValuePrototypeWithDisplayName:subject];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillBodyValue, prefillBodyValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BODY andDisplayName:@"Body" andDataType:DATA_STRING andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)toAddressesOptionPrototype {
    LLOptionValuePrototype *prefillToValue = [LLOptionValuePrototypeFactory emailsOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];

    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillToValue, prefillToValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_TO_ADDRESSES andDisplayName:@"To" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)ccAddressesOptionPrototype {
    LLOptionValuePrototype *prefillCcValue = [LLOptionValuePrototypeFactory emailsOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];

    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillCcValue, prefillCcValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_CC_ADDRESSES andDisplayName:@"Cc" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)bccAddressesOptionPrototype {
    LLOptionValuePrototype *prefillBccValue = [LLOptionValuePrototypeFactory emailsOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillBccValue, prefillBccValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BCC_ADDRESSES andDisplayName:@"Bcc" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)urlAddressesOptionPrototype {
    LLOptionValuePrototype *prefillUrlvalue = [LLOptionValuePrototypeFactory urlsOptionValuePrototypeWithDisplayName:@"http://lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillUrlvalue, prefillUrlvalue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_URLS andDisplayName:@"URLs" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)fileAttachmentsOptionPrototype {
    LLOptionValuePrototype *fileValue = [LLOptionValuePrototypeFactory fileAttachmentsOptionValuePrototypeWithDisplayName:@"Pick now"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    fileValue, fileValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_FILE_ATTACHMENTS andDisplayName:@"File attachments" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)imageAttachmentsOptionPrototype {
    LLOptionValuePrototype *imageValue = [LLOptionValuePrototypeFactory imageAttachmentsOptionValuePrototypeWithDisplayName:@"Pick now"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    imageValue, imageValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];

    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_IMAGE_ATTACHMENTS andDisplayName:@"Images" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

@end

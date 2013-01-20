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

+ (LLOptionPrototype *)optionPrototypeWithKey:(NSString *)key {
    if ([key isEqualToString:OPTION_SUBJECT]) {
        return [self subjectOptionPrototype];
    }
    if ([key isEqualToString:OPTION_BODY]) {
        return [self bodyOptionPrototype];
    }
    if([key isEqualToString:OPTION_TO_ADDRESSES]) {
        return [self toAddressesOptionPrototype];
    }
    if([key isEqualToString:OPTION_CC_ADDRESSES]) {
        return [self ccAddressesOptionPrototype];
    }
    if([key isEqualToString:OPTION_BCC_ADDRESSES]) {
        return [self bccAddressesOptionPrototype];
    }
    if ([key isEqualToString:OPTION_FILE_ATTACHMENTS]) {
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
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SUBJECT andDisplayName:@"Subject" andDataType:DATA_OBJECT andPossibleValues:possibleValues];
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
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BODY andDisplayName:@"Body" andDataType:DATA_OBJECT andPossibleValues:possibleValues];
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

+ (LLOptionPrototype *)urlOptionPrototype {
    LLOptionValuePrototype *prefillUrlvalue = [LLOptionValuePrototypeFactory urlOptionValuePrototypeWithDisplayName:@"http://lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillUrlvalue, prefillUrlvalue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_URL andDisplayName:@"URL" andDataType:DATA_OBJECT andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)fileAttachmentsOptionPrototype {
    LLOptionValuePrototype *fileValue = [LLOptionValuePrototypeFactory fileAttachmentsOptionValuePrototypeWithDisplayName:@"Pick now"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    LLOptionValuePrototype *imageFromCameraRoll = [LLOptionValuePrototypeFactory imageFromCameraRollOptionValuePrototypeWithDisplayName:@"Last Photo"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    fileValue, fileValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    imageFromCameraRoll, imageFromCameraRoll.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_FILE_ATTACHMENTS andDisplayName:@"File attachments" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)imageOptionPrototype {
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    LLOptionValuePrototype *imageFromCameraRoll = [LLOptionValuePrototypeFactory imageFromCameraRollOptionValuePrototypeWithDisplayName:@"Last Photo"];
    LLOptionValuePrototype *imagePickLater = [LLOptionValuePrototypeFactory imagePickLaterOptionValuePrototypeWithDisplayName:@"Pick Later"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    pasteboardValue, pasteboardValue.key,
                                    imageFromCameraRoll, imageFromCameraRoll.key,
                                    imagePickLater, imagePickLater.key,
                                    nil];

    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_IMAGE andDisplayName:@"Image" andDataType:DATA_OBJECT andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)socialsOptionPrototype {
    LLOptionValuePrototype *facebookValue = [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_SERVICE_TYPE_FACEBOOK andDisplayName:@"Facebook" andType:TYPE_STRING];
    LLOptionValuePrototype *twitterVallue = [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_SERVICE_TYPE_TWITTER andDisplayName:@"Twitter" andType:TYPE_STRING];
    LLOptionValuePrototype *googlePlusValue = [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_SERVICE_TYPE_GOOGLE_PLUS andDisplayName:@"Google Plus" andType:TYPE_STRING];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    facebookValue, facebookValue.key,
                                    twitterVallue, twitterVallue.key,
                                    googlePlusValue, googlePlusValue.key,
                                    nil];
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SERVICE_TYPES andDisplayName:@"Services" andDataType:DATA_ARRAY andPossibleValues:possibleValues];
    return optionPrototype;
}

@end

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

+(LLOptionPrototype *)subjectOptionPrototype {
    LLOptionValuePrototype *prefillSubjectValue = [LLOptionValuePrototypeFactory stringOptionValuePrototypeWithDisplayName:@"Subject"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillSubjectValue, prefillSubjectValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SUBJECT andDisplayName:@"Subject" andDataType:DATA_OBJECT andValueType:TYPE_STRING andPossibleValues:possibleValues];
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
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BODY andDisplayName:@"Body" andDataType:DATA_OBJECT andValueType:TYPE_STRING andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)toAddressesOptionPrototype {
    return [LLOptionPrototypeFactory emailsOptionPrototypeWithKey:OPTION_TO_ADDRESSES andDisplayName:@"To"];
}

+ (LLOptionPrototype *)ccAddressesOptionPrototype {
    return [LLOptionPrototypeFactory emailsOptionPrototypeWithKey:OPTION_CC_ADDRESSES andDisplayName:@"Cc"];
}

+ (LLOptionPrototype *)bccAddressesOptionPrototype {
    return [LLOptionPrototypeFactory emailsOptionPrototypeWithKey:OPTION_BCC_ADDRESSES andDisplayName:@"Bcc"];
}

+ (LLOptionPrototype *)emailsOptionPrototypeWithKey:(NSString *)key andDisplayName:(NSString *)displayName {
    LLOptionValuePrototype *prefillCcValue = [LLOptionValuePrototypeFactory stringOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *prefillEmailsPickNowValue = [LLOptionValuePrototypeFactory prefillEmailsPickNowOptionValuePrototypeWithDisplayName:@"Pick Now"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillCcValue, prefillCcValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    prefillEmailsPickNowValue, prefillEmailsPickNowValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:key andDisplayName:displayName andDataType:DATA_ARRAY andValueType:TYPE_EMAIL andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)urlOptionPrototype {
    LLOptionValuePrototype *prefillUrlvalue = [LLOptionValuePrototypeFactory stringOptionValuePrototypeWithDisplayName:@"http://lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillUrlvalue, prefillUrlvalue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_URL andDisplayName:@"URL" andDataType:DATA_OBJECT andValueType:TYPE_URL andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)fileAttachmentsOptionPrototype {
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    LLOptionValuePrototype *imageFromCameraRoll = [LLOptionValuePrototypeFactory imageFromCameraRollOptionValuePrototypeWithDisplayName:@"Last Photo"];
    LLOptionValuePrototype *imagePickLater = [LLOptionValuePrototypeFactory imagePickLaterOptionValuePrototypeWithDisplayName:@"Pick Later"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    pasteboardValue, pasteboardValue.key,
                                    imageFromCameraRoll, imageFromCameraRoll.key,
                                    imagePickLater, imagePickLater.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_FILE_ATTACHMENTS andDisplayName:@"File attachments" andDataType:DATA_ARRAY andValueType:TYPE_FILE andPossibleValues:possibleValues];
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

    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_IMAGE andDisplayName:@"Image" andDataType:DATA_OBJECT andValueType:TYPE_IMAGE andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)socialsOptionPrototype {
    LLOptionValuePrototype *facebookValue = [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_SERVICE_TYPE_FACEBOOK andDisplayName:@"Facebook"];
    LLOptionValuePrototype *twitterVallue = [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_SERVICE_TYPE_TWITTER andDisplayName:@"Twitter"];
    LLOptionValuePrototype *googlePlusValue = [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_SERVICE_TYPE_GOOGLE_PLUS andDisplayName:@"Google Plus"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    facebookValue, facebookValue.key,
                                    twitterVallue, twitterVallue.key,
                                    googlePlusValue, googlePlusValue.key,
                                    nil];
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SERVICE_TYPES andDisplayName:@"Services" andDataType:DATA_ARRAY andValueType:TYPE_STRING andPossibleValues:possibleValues];
    return optionPrototype;
}

@end

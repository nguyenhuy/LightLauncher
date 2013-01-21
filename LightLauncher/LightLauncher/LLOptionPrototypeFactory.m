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
    LLOptionValuePrototype *prefillSubjectValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"Subject"];
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
    LLOptionValuePrototype *prefillBodyValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:subject];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillBodyValue, prefillBodyValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BODY andDisplayName:@"Body" andDataType:DATA_OBJECT andValueType:TYPE_STRING andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)toAddressesOptionPrototype {
    LLOptionValuePrototype *prefillToValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];

    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillToValue, prefillToValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_TO_ADDRESSES andDisplayName:@"To" andDataType:DATA_ARRAY andValueType:TYPE_EMAIL andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)ccAddressesOptionPrototype {
    LLOptionValuePrototype *prefillCcValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];

    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillCcValue, prefillCcValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_CC_ADDRESSES andDisplayName:@"Cc" andDataType:DATA_ARRAY andValueType:TYPE_EMAIL andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)bccAddressesOptionPrototype {
    LLOptionValuePrototype *prefillBccValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"support@lightlauncher.com"];
    LLOptionValuePrototype *pasteboardValue = [LLOptionValuePrototypeFactory pasteboardOptionValuePrototype];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefillBccValue, prefillBccValue.key,
                                    pasteboardValue, pasteboardValue.key,
                                    nil];
    
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_BCC_ADDRESSES andDisplayName:@"Bcc" andDataType:DATA_ARRAY andValueType:TYPE_EMAIL andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)urlOptionPrototype {
    LLOptionValuePrototype *prefillUrlvalue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"http://lightlauncher.com"];
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
    LLOptionValuePrototype *facebookValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"Facebook"];
    LLOptionValuePrototype *twitterVallue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"Twitter"];
    LLOptionValuePrototype *googlePlusValue = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"Google Plus"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    facebookValue, facebookValue.key,
                                    twitterVallue, twitterVallue.key,
                                    googlePlusValue, googlePlusValue.key,
                                    nil];
    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_SERVICE_TYPES andDisplayName:@"Services" andDataType:DATA_ARRAY andValueType:TYPE_STRING andPossibleValues:possibleValues];
    return optionPrototype;
}

+ (LLOptionPrototype *)createNewTabOptionPrototype {
    LLOptionValuePrototype *prefill = [LLOptionValuePrototypeFactory prefillOptionValuePrototypeWithDisplayName:@"Yes"];
    
    NSDictionary *possibleValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    prefill, prefill.key,
                                    nil];

    LLOptionPrototype *optionPrototype = [[LLOptionPrototype alloc] initWithKey:OPTION_CREATE_NEW_TAB andDisplayName:@"Open in new tab" andDataType:DATA_OBJECT andValueType:TYPE_BOOLEAN andPossibleValues:possibleValues];
    return optionPrototype;
}

@end

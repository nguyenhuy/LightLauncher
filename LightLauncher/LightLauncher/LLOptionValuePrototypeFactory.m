//
//  LLOptionValuePrototypeFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/5/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionValuePrototypeFactory.h"
#import "LLOptionValuePrototype.h"

@implementation LLOptionValuePrototypeFactory

+ (LLOptionValuePrototype *)stringOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL andDisplayName:displayName];
}

+ (LLOptionValuePrototype *)prefillEmailsPickNowOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL_EMAILS_PICK_NOW andDisplayName:displayName];
}

+ (LLOptionValuePrototype *)pasteboardOptionValuePrototype {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PASTEBOARD andDisplayName:DISPLAY_NAME_PASTEBOARD_OPTION_VALUE];
}

+ (LLOptionValuePrototype *)imageFromCameraRollOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_CAMERA_ROLL andDisplayName:displayName];
}

+ (LLOptionValuePrototype *)imagePickLaterOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_IMAGE_PICK_LATER andDisplayName:displayName];
}

@end

//
//  LLOptionValuePrototypeFactory.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/5/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionValuePrototypeFactory.h"
#import "Constants.h"

@implementation LLOptionValuePrototypeFactory

+ (LLOptionValuePrototype *)stringOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL andDisplayName:displayName andType:TYPE_STRING];
}

+ (LLOptionValuePrototype *)emailsOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL andDisplayName:displayName andType:TYPE_EMAIL];
}

+ (LLOptionValuePrototype *)urlsOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL andDisplayName:displayName andType:TYPE_URL];
}

+ (LLOptionValuePrototype *)fileAttachmentsOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL andDisplayName:displayName andType:TYPE_FILE];
}

+ (LLOptionValuePrototype *)imageAttachmentsOptionValuePrototypeWithDisplayName:(NSString *)displayName {
    return [[LLOptionValuePrototype alloc] initWithKey:OPTION_VALUE_PREFILL andDisplayName:displayName andType:TYPE_IMAGE];
}

@end

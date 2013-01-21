//
//  LLOpenInChromeCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/21/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLOpenInChromeUrlSchemeCommand.h"
#import "OpenInChromeController.h"

@implementation LLOpenInChromeUrlSchemeCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_URL]) {
        if ([value isKindOfClass:[NSURL class]]) {
            self.url = value;
        } else if ([value isKindOfClass:[NSString class]]) {
            self.url = [NSURL URLWithString:value];
        }
    } else if ([key isEqualToString:OPTION_CREATE_NEW_TAB]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            self.createNewTab = [value boolValue];
        }
    }
}

#pragma mark - Url Scheme Command

- (NSString *)title {
    return @"Open in Chrome";
}

- (NSURL *)constructUrl {
    if (!self.url) {
        return nil;
    }
    
    return [[OpenInChromeController sharedInstance] constructChromeUrlFrom:self.url withCallbackURL:nil createNewTabe:self.createNewTab];
}

- (BOOL)isAppInstalled {
    return [[OpenInChromeController sharedInstance] isChromeInstalled];
}

@end

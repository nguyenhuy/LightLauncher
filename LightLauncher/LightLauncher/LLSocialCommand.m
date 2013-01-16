//
//  LLSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/13/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"

@interface LLSocialCommand ()
@end

@implementation LLSocialCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_BODY] && [value isKindOfClass:[NSString class]]) {
        self.body = value;
    } else if ([key isEqualToString:OPTION_URL]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.url = [NSURL URLWithString:value];
        } else if ([value isKindOfClass:[NSURL class]]) {
            self.url = value;
        }
    } else if ([key isEqualToString:OPTION_IMAGE] && [value isKindOfClass:[UIImage class]]) {
        self.image = value;
    } else {
        [super setValue:value forKey:key];
    }
}

@end

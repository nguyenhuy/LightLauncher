//
//  LLInstapaperAddUrlSchemeCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/22/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLInstapaperAddUrlSchemeCommand.h"

@implementation LLInstapaperAddUrlSchemeCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_URL]) {
        if ([value isKindOfClass:[NSURL class]]) {
            self.url = value;
        } else if ([value isKindOfClass:[NSString class]]) {
            self.url = [NSURL URLWithString:value];
        }
    }
}

#pragma mark - URL Scheme command

- (NSString *)title {
    return @"Add To Instapaper";
}

- (NSURL *)urlScheme {
    return [NSURL URLWithString:@"x-callback-instapaper:"];
}

- (NSURL *)constructUrl {
    if (!self.url) {
        return nil;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"x-callback-instapaper://x-callback-url/add?%@", self.url, nil]];
}

@end

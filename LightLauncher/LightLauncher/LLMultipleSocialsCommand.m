//
//  LLMultipleSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/13/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLMultipleSocialsCommand.h"

@implementation LLMultipleSocialsCommand

- (id)init {
    self = [super init];
    if (self) {
        self.urls = [[NSMutableArray alloc] init];
        self.images = [[NSMutableArray alloc] init];
        self.serviceTypes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_SERVICE_TYPES]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self.serviceTypes addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.serviceTypes addObjectsFromArray:value];
        }
    } else if ([key isEqualToString:OPTION_BODY] && [value isKindOfClass:[NSString class]]) {
        self.body = value;
    } else if ([key isEqualToString:OPTION_URLS]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self.urls addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.urls addObjectsFromArray:value];
        }
    } else if ([key isEqualToString:OPTION_IMAGE_ATTACHMENTS]) {
        if ([value isKindOfClass:[UIImage class]]) {
            [self.images addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.images addObjectsFromArray:value];
        }
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    
    LLSocialCommand *command;
    for (NSString *serviceType in self.serviceTypes) {
        command = [[LLSocialCommand alloc] init];
        command.serviceType = serviceType;
        command.body = self.body;
        command.urls = self.urls;
        command.images = self.images;
        
        [command executeWithViewController:viewController withCommandDelegate:delegate];
    }
}

@end

//
//  LLMultipleSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/13/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLMultipleSocialsCommand.h"

@interface LLMultipleSocialsCommand ()

- (void)increaseExecutedServicesCounter;
- (void)executeService;

@end

@implementation LLMultipleSocialsCommand

- (id)init {
    self = [super init];
    if (self) {
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

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    [super executeWithViewController:viewController withCommandDelegate:delegate];
    self.executedServicesCounter = 0;
    [self executeService];
}

- (void)executeService {
    if (self.executedServicesCounter == self.serviceTypes.count) {
        //@TODO may check for result
        [self onFinished];
        return;
    }
    
    LLSocialCommand *command = [[LLSocialCommand alloc] init];
    command.serviceType = [self.serviceTypes objectAtIndex:self.executedServicesCounter];
    command.body = self.body;
    command.url = self.url;
    command.image = self.image;

    [self increaseExecutedServicesCounter];
    [command executeWithViewController:self.viewController withCommandDelegate:self];
}

// Increases executed command, returns true when the counter equals num of services.
- (void)increaseExecutedServicesCounter {
    @synchronized(self) {
        self.executedServicesCounter++;
    }
}

#pragma mark - Command Delegate

- (void)onFinishedCommand:(LLCommand *)command {
    
    [self executeService];
}

- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self executeService];
}

- (void)onCanceledCommand:(LLCommand *)command {
    [self executeService];
}

@end

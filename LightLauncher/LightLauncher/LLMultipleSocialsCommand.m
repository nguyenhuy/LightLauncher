//
//  LLMultipleSocialCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/13/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLMultipleSocialsCommand.h"
#import "LLShareSocialRequestCommand.h"
#import "LLShareFacebookRequestCommand.h"
#import "LLShareTwitterRequestCommand.h"
#import "LLGooglePlusCommand.h"

@interface LLMultipleSocialsCommand ()

- (void)increaseExecutedServicesCounter;
- (void)executeService;

@end

@implementation LLMultipleSocialsCommand

- (id)init {
    self = [super init];
    if (self) {
        self.serviceTypes = [[NSMutableArray alloc] init];
        self.executedServicesCounter = 0;
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
    } else {
        [super setValue:value forKey:key];
    }
}

//@TODO check num of service types and suggest user to use the other commands if there is 1 service type

#pragma mark - Service command protocol

- (BOOL)isServiceAvailable {
    //@TODO may change this
    return YES;
}

- (UIViewController *)constructComposeViewContrroller {
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"LightLauncher";
    composeViewController.hasAttachment = YES;
    composeViewController.attachmentImage = self.image;
    composeViewController.text = [NSString stringWithFormat:@"%@ %@", self.body, self.url];
    composeViewController.delegate = self;
    
    return composeViewController;
}

#pragma mark - RE compose view controller delegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result {
    if (result == REComposeResultCancelled) {
        [self onCanceled];
    } else if (result == REComposeResultPosted) {
        //@TODO get new value from the composer
        [self executeService];
    }
}

#pragma mark - Instance methods

- (void)executeService {
    if (self.executedServicesCounter == self.serviceTypes.count) {
        //@TODO may check for result
        [self onFinished];
        return;
    }
    
    NSString *serviceType = [self.serviceTypes objectAtIndex:self.executedServicesCounter];
    
    LLCommand *command;
    if ([serviceType isEqualToString:OPTION_VALUE_SERVICE_TYPE_FACEBOOK] || [serviceType isEqualToString:OPTION_VALUE_SERVICE_TYPE_TWITTER]) {
        LLShareSocialRequestCommand *c;
        if ([serviceType isEqualToString:OPTION_VALUE_SERVICE_TYPE_FACEBOOK]) {
            c = [[LLShareFacebookRequestCommand alloc] init];
        } else {
            c = [[LLShareTwitterRequestCommand alloc] init];
        }
        
        c.body = self.body;
        c.url = self.url;
        c.image = self.image;
        
        command = c;
    } else if ([serviceType isEqualToString:COMMAND_GOOGLE_PLUS]) {
        LLGooglePlusCommand *c = [[LLGooglePlusCommand alloc] init];
        c.body = self.body;
        c.url = self.url;
        
        command = c;
    }
        
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

//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLReceiptManager.h"
#import "LLCommandParser.h"

#import "LLTwitterCommand.h"
#import "LLEmailCommand.h"
#import "LLFacebookCommand.h"

@interface LLReceiptManager ()
@property (nonatomic, strong, readwrite) NSMutableArray* receipts;
@property (nonatomic, strong, readwrite) NSMutableArray* commands;

- (void)initCommands;
@end

@implementation LLReceiptManager

+ (id)sharedInstance{
    static LLReceiptManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LLReceiptManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        [self initCommands];
    }
    return self;
}

- (void)initCommands {
    // Init fake email command to test
    LLEmailCommand *emailCommand = [[LLEmailCommand alloc] init];
    emailCommand.subject = @"hello";
    emailCommand.body = @"Hello LightLauncher";

    [emailCommand addToAddress:@"allforone1511@gmail.com"];
    [emailCommand addToAddress:@"allforone1511@gmail.com"];
    [emailCommand addToAddress:@"allforone1511@gmail.com"];

    [emailCommand addCcAddress:@"allforone1511@gmail.com"];
    [emailCommand addCcAddress:@"allforone1511@gmail.com"];
    [emailCommand addCcAddress:@"allforone1511@gmail.com"];

    [emailCommand addBccAddress:@"allforone1511@gmail.com"];
    [emailCommand addBccAddress:@"allforone1511@gmail.com"];
    [emailCommand addBccAddress:@"allforone1511@gmail.com"];
    
    [emailCommand addAttachment:@"mail.png"];
    [emailCommand addAttachment:@"mail.png"];
    [emailCommand addAttachment:@"mail.png"];
    
    LLTwitterCommand *twCommand = [[LLTwitterCommand alloc] init];
    twCommand.body = @"Hello Twitter";

    [twCommand addUrl:@"google.com"];
    [twCommand addUrl:@"facebook.com"];
    
    [twCommand addImage:@"twitter.com"];
    [twCommand addImage:@"facebook.com"];
    
    LLFacebookCommand *fbCommand = [[LLFacebookCommand alloc] init];
    fbCommand.body = @"Hello Twitter";
    
    [fbCommand addUrl:@"google.com"];
    [fbCommand addUrl:@"facebook.com"];
    
    [fbCommand addImage:@"twitter.com"];
    [fbCommand addImage:@"facebook.com"];
    
    self.commands = [NSMutableArray arrayWithObjects:
                     twCommand,
                     emailCommand,
                     fbCommand,
                     nil];
}

- (void)executeFromString:(NSString *)string withViewController:(UIViewController *)viewController{
    LLCommand *command = [LLCommandParser decode:string];
    [self executeFromCommand:command withViewController:viewController];
}

- (void)executeFromCommand:(LLCommand *)command withViewController:(UIViewController *)viewController{
    [command executeFromViewController:viewController];
}

@end

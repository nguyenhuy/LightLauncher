//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLReceiptManager.h"
#import "LLTwitterCommand.h"
#import "LLEmailCommand.h"

#import "LLToOption.h"
#import "LLCcOption.h"
#import "LLBccOption.h"
#import "LLSubjectOption.h"
#import "LLBodyOption.h"
#import "LLAttachmentDataOption.h"

@interface LLReceiptManager ()
@property (nonatomic, strong, readwrite) NSMutableArray* receipts;
@property (nonatomic, strong, readwrite) NSMutableArray* commands;
@end

@implementation LLReceiptManager

@synthesize receipts = _receipts;
@synthesize commands = _commands;

- (id)init {
    self = [super init];
    if (self != nil) {
        // Init fake email command to test
        LLEmailCommand *emailCommand = [[LLEmailCommand alloc] initWithName:@"mail"];
        emailCommand.toOptions = [NSMutableArray arrayWithObjects:
                                     [[LLToOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                     [[LLToOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                     [[LLToOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                     nil];
        emailCommand.ccOptions = [NSMutableArray arrayWithObjects:
                                    [[LLCcOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                    [[LLCcOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                    [[LLCcOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                    nil];
        emailCommand.bccOptions = [NSMutableArray arrayWithObjects:
                                   [[LLBccOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                   [[LLBccOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                   [[LLBccOption alloc] initWithParam:@"allforone1511@gmail.com"],
                                   nil];
        emailCommand.subject = [[LLSubjectOption alloc] initWithParam:@"hello"];
        emailCommand.body = [[LLBodyOption alloc] initWithParam:@"Hello LightLauncher" AndIsHtml:NO];
        emailCommand.attachmentFiles = [NSMutableArray arrayWithObjects:
                                        [[LLAttachmentDataOption alloc] initWithParam:@"d/acb.png" AndMimeType:@"image/png" andFileName:@"abc.png"],
                                        [[LLAttachmentDataOption alloc] initWithParam:@"d/acb.png" AndMimeType:@"image/png" andFileName:@"abc.png"],
                                        nil];
        
        self.commands = [NSMutableArray arrayWithObjects:
                         [[LLTwitterCommand alloc] initWithName:@"tw"],
                         emailCommand,
                         nil];
    }
    return self;
}

@end

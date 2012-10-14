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
#import "LLFacebookCommand.h"

#import "LLToOption.h"
#import "LLCcOption.h"
#import "LLBccOption.h"
#import "LLSubjectOption.h"
#import "LLBodyOption.h"
#import "LLAttachmentDataOption.h"
#import "LLUrlOption.h"
#import "LLImageOption.h"

@interface LLReceiptManager ()
@property (nonatomic, strong, readwrite) NSMutableArray* receipts;
@property (nonatomic, strong, readwrite) NSMutableArray* commands;
@end

@implementation LLReceiptManager

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
        emailCommand.subjectOption = [[LLSubjectOption alloc] initWithParam:@"hello"];
        emailCommand.bodyOption = [[LLBodyOption alloc] initWithParam:@"Hello LightLauncher" AndIsHtml:NO];
        emailCommand.attachmentFiles = [NSMutableArray arrayWithObjects:
                                        [[LLAttachmentDataOption alloc]
                                            initWithData:[NSData dataWithContentsOfFile:@"mail.png"]
                                            AndMimeType:@"image/png" AndFileName:@"abc.png"],
                                        [[LLAttachmentDataOption alloc]
                                            initWithData:[NSData dataWithContentsOfFile:@"mail.png"]
                                            AndMimeType:@"image/png" AndFileName:@"abc.png"],
                                        nil];
        
        NSArray *urls = [NSArray arrayWithObjects:
                         [[LLUrlOption alloc] initWithParam:@"google.com"],
                         [[LLUrlOption alloc] initWithParam:@"facebook.com"],
                         nil];
        NSArray *images = [NSArray arrayWithObjects:
                           [[LLImageOption alloc] initWithWithImage:[UIImage imageNamed:@"twitter.png"]],
                           [[LLImageOption alloc] initWithWithImage:[UIImage imageNamed:@"twitter.png"]],
                           nil];
        LLTwitterCommand *twCommand = [[LLTwitterCommand alloc] initWithName:@"tw"];
        twCommand.bodyOption = [[LLBodyOption alloc] initWithParam:@"Hello Twitter"];
        twCommand.urlOptions = urls;
        twCommand.imageOptions = images;
        
        LLFacebookCommand *fbCommand = [[LLFacebookCommand alloc] initWithName:@"fb"];
        fbCommand.bodyOption = [[LLBodyOption alloc] initWithParam:@"Hello FB"];
        fbCommand.urlOptions = urls;
        fbCommand.imageOptions = images;
        
        self.commands = [NSMutableArray arrayWithObjects:
                         twCommand,
                         emailCommand,
                         fbCommand,
                         nil];
    }
    return self;
}

@end

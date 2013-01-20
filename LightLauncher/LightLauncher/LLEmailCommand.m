//
//  LLEmailCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLEmailCommand.h"

@interface LLEmailCommand ()
- (NSArray *)recipientsFromOptions:(NSArray *)toOptions;
- (void)addAttachmentDatasToMailComposeViewController:(MFMailComposeViewController *)controller;
@end

@implementation LLEmailCommand

- (id)init {
    self = [super init];
    if (self) {
        self.serviceType = COMMAND_EMAIL;
        self.serviceName = @"Email";
        self.toAddresses = [[NSMutableArray alloc] init];
        self.ccAddresses = [[NSMutableArray alloc] init];
        self.bccAddresses = [[NSMutableArray alloc] init];
        self.attachments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:OPTION_TO_ADDRESSES]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self.toAddresses addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.toAddresses addObjectsFromArray:value];
        }
    } else if ([key isEqualToString:OPTION_CC_ADDRESSES]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self.ccAddresses addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.ccAddresses addObjectsFromArray:value];
        }
    } else if ([key isEqualToString:OPTION_BCC_ADDRESSES]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self.bccAddresses addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.bccAddresses addObjectsFromArray:value];
        }
    } else if ([key isEqualToString:OPTION_SUBJECT]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.subject = value;
        }
    } else if ([key isEqualToString:OPTION_BODY]) {
        if ([value isKindOfClass:[NSString class]]) {
            self.body = value;
        }
    } else if ([key isEqualToString:OPTION_FILE_ATTACHMENTS]) {
        if ([value isKindOfClass:[NSData class]]) {
            [self.attachments addObject:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [self.attachments addObjectsFromArray:value];
        }
    } else {
        [super setValue:value forKey:key];
    }
}

#pragma mark - Service command protocols

- (BOOL)isServiceAvailable {
    return [MFMailComposeViewController canSendMail];
}

- (UIViewController *)constructComposeViewContrroller {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    [controller setToRecipients:[self recipientsFromOptions:self.toAddresses]];
    [controller setCcRecipients:[self recipientsFromOptions:self.ccAddresses]];
    [controller setBccRecipients:[self recipientsFromOptions:self.bccAddresses]];
    [controller setSubject:self.subject];
    [controller setMessageBody:self.body isHTML:false];
    [self addAttachmentDatasToMailComposeViewController:controller];
    controller.mailComposeDelegate = self;
    return controller;
}

#pragma mark - Instance methods

- (NSArray *)recipientsFromOptions:(NSArray *)addresses {
    NSMutableArray *recipients = [NSMutableArray arrayWithCapacity:addresses.count];
    for (NSString *address in addresses) {
        [recipients addObject:address];
    }
    return recipients;
}

- (void)addAttachmentDatasToMailComposeViewController:(MFMailComposeViewController *)controller {
    for (NSString *path in self.attachments) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        //@TODO get mimetype and filename
        [controller addAttachmentData:data mimeType:@"image/png" fileName:@"path"];
    }
}

#pragma mark - MFMailComposerViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    switch (result) {
        case MFMailComposeResultCancelled:
            [self onCanceled];
            break;
        case MFMailComposeResultSaved:
        case MFMailComposeResultSent:
            [self onFinished];
            break;
        case MFMailComposeResultFailed:
            //@TODO how, when and why this failed???
            [self onErrorWithTitle:@"Failed" andDesc:nil];
            break;
    }
}

@end

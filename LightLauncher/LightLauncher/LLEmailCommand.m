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
    self = [super initWithServiceType:COMMAND_EMAIL andServiceName:@"Email"];
    return self;
}

#pragma mark - Command methods

+ (NSString *)command {
    return COMMAND_EMAIL;
}

+ (NSString *)description {
    return @"Email";
}

+ (NSString *)iconFileName {
    return @"mail.png";
}

#pragma mark - Getters and Setters

- (NSArray *)toAddresses {
    return [self valueForKey:OPTION_TO_ADDRESSES];
}

- (NSArray *)ccAddresses {
    return [self valueForKey:OPTION_CC_ADDRESSES];
}

- (NSArray *)bccAddresses {
    return [self valueForKey:OPTION_BCC_ADDRESSES];
}

- (NSString *)subject {
    return [self valueForKey:OPTION_SUBJECT];
}

- (NSString *)body {
    return [self valueForKey:OPTION_BODY];
}

- (NSArray *)attachments {
    return [self valueForKey:OPTION_FILE_ATTACHMENTS];
}

- (void)addToAddress:(NSString *)address {
    [self addValue:address forKey:OPTION_TO_ADDRESSES];
}

- (void)addCcAddress:(NSString *)address {
    [self addValue:address forKey:OPTION_CC_ADDRESSES];
}

- (void)addBccAddress:(NSString *)address {
    [self addValue:address forKey:OPTION_BCC_ADDRESSES];
}

- (void)setSubject:(NSString *)subject {
    [self setValue:subject forKey:OPTION_SUBJECT];
}

- (void)setBody:(NSString *)body {
    [self setValue:body forKey:OPTION_BODY];
}

- (void)addAttachment:(NSString *)attachment {
    [self addValue:attachment forKey:OPTION_FILE_ATTACHMENTS];
}

#pragma mark - Service methods

- (BOOL)isServiceAvailable {
    return [MFMailComposeViewController canSendMail];
}

- (BOOL)isFinishedAfterPresentingComposeViewController {
    return NO;
}

- (UIViewController *)composeViewController {
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
#warning get mimetype and filename
        [controller addAttachmentData:data mimeType:@"image/png" fileName:@"path"];
    }
}

#pragma mark - MFMailComposerViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    NSString *message;
    switch (result) {
        case MFMailComposeResultCancelled:
            message = @"Message Canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Message Saved";
            break;
        case MFMailComposeResultSent:
            message = @"Message Sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Message Failed";
            break;
        default:
            message = @"Message Not Sent";
            break;
    }
    [self onFinishedWithStatusTitle:@"Email" andMessage:message];
}

@end

//
//  LLEmailCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLEmailCommand.h"
#import "LLToOption.h"
#import "LLCcOption.h"
#import "LLBccOption.h"
#import "LLSubjectOption.h"
#import "LLBodyOption.h"
#import "LLAttachmentDataOption.h"

@interface LLEmailCommand ()
- (NSArray *)recipientsFromOptions:(NSArray *)toOptions;
- (void)addAttachmentDatasToMailComposeViewController:(MFMailComposeViewController *)controller;
@end

@implementation LLEmailCommand

- (NSString *)description {
    return @"Email";
}

- (NSString *)iconFileName {
    return @"mail.png";
}

- (NSString *)serviceName {
    return @"Email";
}

- (BOOL)isServiceAvailable {
    return [MFMailComposeViewController canSendMail];
}

- (BOOL)isFinishedAfterPresentingComposeViewController {
    return NO;
}

- (UIViewController *)composeViewController {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    [controller setToRecipients:[self recipientsFromOptions:self.toOptions]];
    [controller setCcRecipients:[self recipientsFromOptions:self.ccOptions]];
    [controller setBccRecipients:[self recipientsFromOptions:self.bccOptions]];
    [controller setSubject:self.subjectOption.param];
    [controller setMessageBody:self.bodyOption.param isHTML:self.bodyOption.isHtml];
    [self addAttachmentDatasToMailComposeViewController:controller];
    controller.mailComposeDelegate = self;
    return controller;
}

- (NSArray *)recipientsFromOptions:(NSArray *)toOptions {
    NSMutableArray *recipients = [NSMutableArray arrayWithCapacity:toOptions.count];
    for (LLToOption *o in toOptions) {
        [recipients addObject:o.param];
    }
    return recipients;
}

- (void)addAttachmentDatasToMailComposeViewController:(MFMailComposeViewController *)controller {
    for (LLAttachmentDataOption *o in self.attachmentFiles) {
        [controller addAttachmentData:o.data mimeType:o.mimeType fileName:o.fileName];
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

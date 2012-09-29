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
- (NSArray *)recipientsFromToOptions:(NSArray *)toOptions;
- (void)addAttachmentDatasToMailComposeViewController:(MFMailComposeViewController *)controller;
@end

@implementation LLEmailCommand

@synthesize viewController = _viewController;
@synthesize toOptions = _toOptions;
@synthesize ccOptions = _ccOptions;
@synthesize bccOptions = _bccOptions;
@synthesize subjectOption = _subjectOption;
@synthesize bodyOption = _bodyOption;
@synthesize attachmentFiles = _attachmentFiles;

- (NSString *)description {
    return @"Email";
}

- (NSString *)iconFileName {
    return @"mail.png";
}

- (void) executeFromViewController:(UIViewController *)viewController {
    self.viewController = viewController;
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setToRecipients:[self recipientsFromToOptions:self.toOptions]];
        [controller setCcRecipients:[self recipientsFromToOptions:self.ccOptions]];
        [controller setBccRecipients:[self recipientsFromToOptions:self.bccOptions]];
        [controller setSubject:self.subjectOption.param];
        [controller setMessageBody:self.bodyOption.param isHTML:self.bodyOption.isHtml];
        [self addAttachmentDatasToMailComposeViewController:controller];
        controller.mailComposeDelegate = self;
        [self.viewController presentViewController:controller animated:YES completion:nil];
    } else {
#warning can't send mail, warn user
    }
}

#pragma mark - MFMailComposerViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status:" message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    
    switch (result) {
        case MFMailComposeResultCancelled:
            alert.message = @"Message Canceled";
            break;
        case MFMailComposeResultSaved:
            alert.message = @"Message Saved";
            break;
        case MFMailComposeResultSent:
            alert.message = @"Message Sent";
            break;
        case MFMailComposeResultFailed:
            alert.message = @"Message Failed";
            break;
        default:
            alert.message = @"Message Not Sent";
            break;
    }
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    self.viewController = nil;
    [alert show];
}

- (NSArray *)recipientsFromToOptions:(NSArray *)toOptions {
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

@end

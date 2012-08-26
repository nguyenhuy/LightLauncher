//
//  LLEmailCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLEmailCommand.h"

@implementation LLEmailCommand

@synthesize viewController = _viewController;

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
        [controller setSubject:@"Subject"];
        [controller setToRecipients:[NSArray arrayWithObject:@"allforone1511@gmail.com"]];
        [controller setCcRecipients:[NSArray arrayWithObject:@"huy.nguyen151190@gmail.com"]];
        [controller setBccRecipients:[NSArray arrayWithObject:@"allforone1511@yahoo.com"]];
        [controller setMessageBody:@"Body" isHTML:NO];
        [controller addAttachmentData:[NSData dataWithContentsOfFile:@"mail.png"] mimeType:@"image/png" fileName:@"Mail icon"];
        controller.mailComposeDelegate = self;
        [self.viewController presentModalViewController:controller animated:YES];
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
    
    [self.viewController dismissModalViewControllerAnimated:YES];
    self.viewController = nil;
    [alert show];
}



@end

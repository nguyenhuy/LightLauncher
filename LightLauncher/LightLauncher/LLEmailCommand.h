//
//  LLEmailCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLServiceCommand.h"
#import <MessageUI/MessageUI.h>

@class LLToOption;
@class LLSubjectOption;
@class LLBodyOption;

@interface LLEmailCommand : LLServiceCommand <MFMailComposeViewControllerDelegate>

- (NSArray *)toAddresses;
- (NSArray *)ccAddresses;
- (NSArray *)bccAddresses;
- (NSString *)subject;
- (NSString *)body;
- (NSArray *)attachments;

- (void)addToAddress:(NSString *)address;
- (void)addCcAddress:(NSString *)address;
- (void)addBccAddress:(NSString *)address;
- (void)setSubject:(NSString *)subject;
- (void)setBody:(NSString *)body;
- (void)addAttachment:(NSString *)attachment;

@end

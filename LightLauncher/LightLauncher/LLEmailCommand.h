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

// Array of email NSStrings
@property (nonatomic, strong) NSMutableArray *toAddresses;
// Array of email NSStrings
@property (nonatomic, strong) NSMutableArray *ccAddresses;
// Array of email NSStrings
@property (nonatomic, strong) NSMutableArray *bccAddresses;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
// Arrray of NSData
@property (nonatomic, strong) NSMutableArray *attachments;

@end

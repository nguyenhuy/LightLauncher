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

@property (nonatomic, strong) NSArray *toOptions;
@property (nonatomic, strong) NSArray *ccOptions;
@property (nonatomic, strong) NSArray *bccOptions;
@property (nonatomic, strong) LLSubjectOption *subjectOption;
@property (nonatomic, strong) LLBodyOption *bodyOption;
@property (nonatomic, strong) NSArray *attachmentFiles;

@end

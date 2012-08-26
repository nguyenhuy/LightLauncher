//
//  LLEmailCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"
#import <MessageUI/MessageUI.h>

@interface LLEmailCommand : LLCommand <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIViewController *viewController;

@end

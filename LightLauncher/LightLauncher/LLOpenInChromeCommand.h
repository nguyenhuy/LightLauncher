//
//  LLOpenInChromeCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/21/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLServiceCommand.h"
#import "REComposeViewController.h"

@interface LLOpenInChromeCommand : LLServiceCommand <REComposeViewControllerDelegate>;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic) BOOL createNewTab;

@end

//
//  LLCreateCommandViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/29/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPrefillOptionValuePrototypeCell.h"
#import "LLLikeCommandHelper.h"
#import "LLCommand.h"

#define NIB_CREATE_COMMAND_VIEW_CONTROLLER @"LLCreateCommandTableViewController"

@class LLCommandPrototype;
@class LLCommand;

@interface LLCreateCommandTableViewController : UITableViewController <LLPrefillOptionValuePrototypeCellDelegate, LLLikeCommandHelperDelegate, LLCommandDelegate>

@property (nonatomic, strong) LLCommandPrototype *commandPrototype;
@property (nonatomic, strong) LLLikeCommandHelper *likeReceiptHelper;

- (void)likeCommand;
- (void)executeCommand;

@end

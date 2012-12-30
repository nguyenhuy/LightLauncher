//
//  LLCreateCommandViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/29/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPrefillOptionValuePrototypeCell.h"
#import "LLLikeReceiptHelper.h"

#define NIB_CREATE_COMMAND_VIEW_CONTROLLER @"LLCreateCommandTableViewController"

@class LLCommandPrototype;
@class LLCommand;

@interface LLCreateCommandTableViewController : UITableViewController <LLPrefillOptionValuePrototypeCellDelegate, LLLikeReceiptHelperDelegate>

@property (nonatomic, strong) LLCommandPrototype *commandPrototype;
@property (nonatomic, strong) LLLikeReceiptHelper *likeReceiptHelper;

- (void)likeCommand;
- (void)executeCommand;

@end

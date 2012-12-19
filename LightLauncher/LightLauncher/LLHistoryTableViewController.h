//
//  LLHistoryTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHistoryCell.h"

@class Receipt;
@interface LLHistoryTableViewController : UITableViewController <LLHistoryCellDelegate>

+ (LLHistoryTableViewController *)newInstance;

- (void)edit;
- (void)doneEditting;

@end

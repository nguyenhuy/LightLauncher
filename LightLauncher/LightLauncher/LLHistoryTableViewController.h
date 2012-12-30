//
//  LLHistoryTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryCell.h"
#import "LLLikeReceiptHelper.h"

@class Receipt;

@interface LLHistoryTableViewController : UITableViewController <LLHistoryCellDelegate, LLLikeReceiptHelperDelegate>

@property (nonatomic, strong) NSArray *receipts;
@property (nonatomic, strong) LLLikeReceiptHelper* likeReceiptHelper;

+ (LLHistoryTableViewController *)newInstance;

- (void)edit;
- (void)doneEditting;

@end

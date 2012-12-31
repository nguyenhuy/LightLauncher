//
//  LLHistoryTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryCell.h"
#import "LLLikeReceiptHelper.h"
#import "LLCommand.h"

@class Receipt;

@interface LLHistoryTableViewController : UITableViewController <LLHistoryCellDelegate, LLLikeReceiptHelperDelegate, LLCommandDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) LLLikeReceiptHelper* likeReceiptHelper;

+ (LLHistoryTableViewController *)newInstance;

- (void)edit;
- (void)doneEditting;

@end

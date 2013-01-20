//
//  LLHistoryTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryCell.h"
#import "LLLikeCommandHelper.h"
#import "LLCommand.h"

@interface LLHistoryTableViewController : UITableViewController <LLHistoryCellDelegate, LLLikeCommandHelperDelegate, LLCommandDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) LLLikeCommandHelper* likeReceiptHelper;

+ (LLHistoryTableViewController *)newInstance;

- (void)edit;
- (void)doneEditting;

@end

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
#import "KNPathTableViewController.h"

#define KNPathTableFadeInDuration         0.3
#define KNPathTableFadeOutDuration        0.3
#define KNPathTableFadeOutDelay           0.5
#define KNPathTableSlideInOffset         16.0
#define KNPathTableOverlayDefaultSize    CGSizeMake(150, 32)

@class Receipt;

@interface LLHistoryTableViewController : UITableViewController <LLHistoryCellDelegate, LLLikeReceiptHelperDelegate, LLCommandDelegate>

@property (nonatomic, strong) NSArray *receipts;
@property (nonatomic, strong) LLLikeReceiptHelper* likeReceiptHelper;

#pragma mark - for Path overlay
@property (nonatomic, strong) UIView * infoPanel;
@property (nonatomic) CGSize infoPanelSize;
@property (nonatomic) CGRect infoPanelInitialFrame;
@property (nonatomic) CGFloat initalScrollIndicatorHeight;

+ (LLHistoryTableViewController *)newInstance;

- (void)edit;
- (void)doneEditting;

@end

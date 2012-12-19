//
//  LLHistoryCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDENTIFIER_HISTORY_CELL @"LLHistoryCell"

@protocol LLHistoryCellDelegate <NSObject>
- (void)onLikeReceiptAtIndexPath:(NSIndexPath *)indexPath;
@end

@class Receipt;

@interface LLHistoryCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<LLHistoryCellDelegate> delegate;

- (void)updateViewWithReceipt:(Receipt *)receipt atIndexPath:(NSIndexPath *)indexPath andDelegate:(id<LLHistoryCellDelegate>)delegate;
- (void)like;

@end

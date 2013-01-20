//
//  LLHistoryCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSideSwipeMenu.h"

#define IDENTIFIER_HISTORY_CELL @"LLHistoryCell"

@protocol LLHistoryCellDelegate <NSObject>
- (void)onToggleGroupOfReceiptAtIndexPath:(NSIndexPath *)indexPath;
- (void)onDuplicateReceiptAtIndexPath:(NSIndexPath *)indexPath;
@end

@class HistoryReceipt;

@interface LLHistoryCell : UITableViewCell <LLSideSwipeMenuDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<LLHistoryCellDelegate> delegate;
@property (nonatomic, strong) LLSideSwipeMenu *menu;

- (void)updateViewWithHistoryReceipt:(HistoryReceipt *)receipt atIndexPath:(NSIndexPath *)indexPath andDelegate:(id<LLHistoryCellDelegate>)delegate;
- (void)onShowSwipeSideMenu;

@end

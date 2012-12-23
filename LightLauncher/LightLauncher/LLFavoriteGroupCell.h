//
//  LLGroupCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#define NIB_FAVORITE_GROUP_CELL @"LLFavoriteGroupCell"
#define IDENTIFIER_FAVORITE_GROUP_CELL @"LLFavoriteGroupCell"

#import "LLFavoriteReceiptCell.h"

@class Group;

@protocol LLFavoriteGroupCellDelegate <NSObject>

- (UIViewController *)viewControllerToExecuteCommand;

@end

// Cell for a group of favorite commands, which contains a -90 degree rotated UITableView
// Size tableViewInsideCell is 100x320, so we can contain 3 cells with size of 100x100 after rotating. And we still have 20pixels on the left to indicate the next cell
@interface LLFavoriteGroupCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate, LLFavoriteReceiptCellDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableViewInsideCell;
@property (nonatomic, strong) Group *group;
@property (nonatomic, strong) NSArray *receipts;
@property (nonatomic, weak) id<LLFavoriteGroupCellDelegate> delegate;

- (void)updateViewWithGroup:(Group *)group andDelegate:(id<LLFavoriteGroupCellDelegate>)delegate;

@end

//
//  LLGroupCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#define NIB_FAVORITE_GROUP_CELL @"LLFavoriteGroupCell"
#define IDENTIFIER_FAVORITE_GROUP_CELL @"LLFavoriteGroupCell"

@class Receipt;

// Cell for a group of favorite commands, which contains a -90 degree rotated UITableView
// Size is 64x320, so we can contain 5 cells with size of 64x64 after rotating.
@interface LLFavoriteGroupCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableViewInsideCell;
@property (nonatomic, strong) NSArray *receipts;

- (void)updateViewWithReceipts:(NSArray *)receipts;

@end

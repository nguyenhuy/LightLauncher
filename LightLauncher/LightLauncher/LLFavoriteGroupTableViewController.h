//
//  LLFavoriteGroupTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"

@class DnDOverlayView;

@interface LLFavoriteGroupTableViewController : UIViewController <LLFavoriteGroupCellDelegate>

@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet DnDOverlayView *overlayView;

+ (LLFavoriteGroupTableViewController *)newInstance;

@end

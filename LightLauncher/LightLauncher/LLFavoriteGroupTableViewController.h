//
//  LLFavoriteGroupTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"

@interface LLFavoriteGroupTableViewController : UITableViewController <LLFavoriteGroupCellDelegate>

@property (nonatomic, strong) NSArray *groups;

+ (LLFavoriteGroupTableViewController *)newInstance;

@end

//
//  LLFavoriteGroupTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"
#import "LLCommand.h"

@interface LLFavoriteGroupTableViewController : UITableViewController <LLFavoriteGroupCellDelegate, LLCommandDelegate>

@property (nonatomic, strong) NSArray *groups;

+ (LLFavoriteGroupTableViewController *)newInstance;

@end

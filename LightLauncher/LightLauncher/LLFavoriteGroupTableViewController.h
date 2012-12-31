//
//  LLFavoriteGroupTableViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"
#import "LLCommand.h"

@interface LLFavoriteGroupTableViewController : UITableViewController <LLFavoriteGroupCellDelegate, LLCommandDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

+ (LLFavoriteGroupTableViewController *)newInstance;

@end

//
//  LLRearViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@interface LLRearViewController : UITableViewController

@property (strong, nonatomic) NSIndexPath *indexPathSavingTime;
@property (strong, nonatomic) NSIndexPath *indexPathFavorite;
@property (strong, nonatomic) NSIndexPath *indexPathCreate;
@property (strong, nonatomic) NSIndexPath *indexPathHistory;

+ (LLRearViewController *)newInstance;

#pragma mark - LLSavingTimeManager delegate
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

@end

//
//  LLRearViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLRearViewController.h"
#import "LLRevealController.h"
#import "LLSavingTimeManager.h"

@interface LLRearViewController ()
- (LLRevealController *)revealController;
@end

@implementation LLRearViewController

+ (LLRearViewController *)newInstance {
    return [[LLRearViewController alloc] initWithNibName:@"LLRearViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 2 sections:
        //      Saving time: 1 row
        //      Views: 3 rows:
        //          Favorite
        //          Create
        //          History
        self.indexPathSavingTime = [NSIndexPath indexPathForRow:0 inSection:0];

        self.indexPathFavorite = [NSIndexPath indexPathForRow:0 inSection:1];
        self.indexPathCreate = [NSIndexPath indexPathForRow:1 inSection:1];
        self.indexPathHistory = [NSIndexPath indexPathForRow:2 inSection:1];
        
        [LLSavingTimeManager addObserver:self];
    }
    return self;
}

- (void)dealloc {
    [LLSavingTimeManager removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Total Saving Time";
        case 1:
            return @"Views";
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *title;
    if ([self.indexPathSavingTime compare:indexPath] == NSOrderedSame) {
        NSUInteger seconds = [LLSavingTimeManager totalSavingTime];
        title = [NSString stringWithFormat:@"%02u:%02u:%02u", seconds / 3600, (seconds / 60) % 60, seconds % 60];
    } else if ([self.indexPathFavorite compare:indexPath] == NSOrderedSame) {
        title = @"Favorite";
    } else if ([self.indexPathCreate compare:indexPath] == NSOrderedSame) {
        title = @"Create";
    } else if ([self.indexPathHistory compare:indexPath] == NSOrderedSame) {
        title = @"History";
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LLRevealController *revealController = [self revealController];
    if ([self.indexPathSavingTime compare:indexPath] == NSOrderedSame) {
    } else if ([self.indexPathFavorite compare:indexPath] == NSOrderedSame) {
        [revealController showFavoriteGroup];
    } else if ([self.indexPathCreate compare:indexPath] == NSOrderedSame) {
        [revealController showCreateGroup];
    } else if ([self.indexPathHistory compare:indexPath] == NSOrderedSame) {
        [revealController showHistoryGroup];
    }
}

#pragma mark - Instance methods

- (LLRevealController *)revealController {
    return [self.parentViewController isKindOfClass:[LLRevealController class]] ? (LLRevealController *)self.parentViewController : nil;
}

#pragma mark - LLSavingTimeManager delegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // Only observe the saving time now, so don't need to check for keyPath
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPathSavingTime] withRowAnimation:UITableViewRowAnimationFade];
    //@TODO: may run animation now
}

@end

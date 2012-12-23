//
//  LLFavoriteGroupTableViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupTableViewController.h"

#import "LLCommandManager.h"
#import "LLCommandParser.h"

#import "LLFavoriteGroupCell.h"

#import "Group.h"

#import "DnDOverlayView.h"

@interface LLFavoriteGroupTableViewController ()
@end

@implementation LLFavoriteGroupTableViewController

+ (LLFavoriteGroupTableViewController *)newInstance {
    return [[LLFavoriteGroupTableViewController alloc] initWithNibName:@"LLFavoriteGroupTableViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Favorite";
    
    [self.tableView registerNib:[UINib nibWithNibName:NIB_FAVORITE_GROUP_CELL bundle:nil] forCellReuseIdentifier:IDENTIFIER_FAVORITE_GROUP_CELL];
    // Don't need table view anymore, remove the reference
    self.tableView = nil;
    
    self.overlayView.overlayId = OVERLAY_ID_FAV_GROUP;
    // Don't need the view anymore, remove the reference
    self.overlayView = nil;
    
    //@TODO may abstract this.
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
        
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reveal", @"Reveal") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
    
    self.groups = [LLCommandManager loadGroupsFromDB];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Group *group = [self.groups objectAtIndex:section];
    return group.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Group *group = [self.groups objectAtIndex:indexPath.row];
    
    LLFavoriteGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_GROUP_CELL forIndexPath:indexPath];
    [cell updateViewWithGroup:group andDelegate:self];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Favorite group cell delegate

- (UIViewController *)viewControllerToExecuteCommand {
    return self;
}

@end

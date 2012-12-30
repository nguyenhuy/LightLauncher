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

#import "UIViewController+ShowHUD.h"
#import "UIViewController+SetupSideMenu.h"

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
    [self setupSideMenu];
    
    self.groups = [LLCommandManager loadGroupsFromDB];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Group *group = [self.groups objectAtIndex:section];
    return group.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Group *group = [self.groups objectAtIndex:indexPath.section];
    
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

- (id<LLCommandDelegate>)commandDelegate {
    return self;
}

#pragma mark - Command delegate

- (void)onFinishedCommand:(id)command {
    [self showExecutedCommandHUD];
}

- (void)onStoppedCommand:(id)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self showErrorHUDWithTitle:title andDesc:desc];
}

@end

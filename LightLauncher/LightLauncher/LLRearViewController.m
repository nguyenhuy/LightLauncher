//
//  LLRearViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLRearViewController.h"
#import "LLRevealController.h"

@interface LLRearViewController ()
- (LLRevealController *)revealController;
@end

@implementation LLRearViewController

+ (LLRearViewController *)newInstance {
    return [[LLRearViewController alloc] initWithNibName:@"LLRearViewController" bundle:nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int row = indexPath.row;
    NSString *title;
    //@TODO may use array here and merge with Constants.ViewControllerGroup
    if (row == 0) {
        title = @"Create";
    } else if (row == 1) {
        title = @"History";
    } else if (row == 2) {
        title = @"Favorite";
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLRevealController *revealController = [self revealController];
    int row = indexPath.row;
    if (row == 0) {
        [revealController showCreateGroup];
    } else if (row == 1) {
        [revealController showHistoryGroup];
    } else if (row == 2) {
        [revealController showFavoriteGroup];
    }
}

#pragma mark - Instance methods

- (LLRevealController *)revealController {
    return [self.parentViewController isKindOfClass:[LLRevealController class]] ? (LLRevealController *)self.parentViewController : nil;
}

@end

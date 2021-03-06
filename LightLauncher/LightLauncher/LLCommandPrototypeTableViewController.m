//
//  LLCreateCommandViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandPrototypeTableViewController.h"
#import "LLCommandManager.h"
#import "LLCommandPrototypeCell.h"
#import "LLCreateCommandTableViewController.h"
#import "UIViewController+SetupSideMenu.h"

@interface LLCommandPrototypeTableViewController ()

@end

@implementation LLCommandPrototypeTableViewController

+ (LLCommandPrototypeTableViewController *)newInstance {
    return [[LLCommandPrototypeTableViewController alloc] initWithNibName:NIB_COMMAND_PROTOTYPE_TABLE_VIEW_CONTROLLER bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Commands";
    
    [self.tableView registerClass:[LLCommandPrototypeCell class] forCellReuseIdentifier:IDENTIFIER_COMMAND_PROTOTYPE_CELL];
    [self setupSideMenu];
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillAppear:(BOOL)animated {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[LLCommandManager sharedInstance] commandPrototypes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLCommandPrototype *commandPrototype = [[[LLCommandManager sharedInstance] commandPrototypes] objectAtIndex:indexPath.row];

    LLCommandPrototypeCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_COMMAND_PROTOTYPE_CELL forIndexPath:indexPath];
    [cell updateViewWithCommandPrototype:commandPrototype];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LLCreateCommandTableViewController *controller = [[LLCreateCommandTableViewController alloc] initWithNibName:NIB_CREATE_COMMAND_VIEW_CONTROLLER bundle:nil];
    controller.commandPrototype = [[[LLCommandManager sharedInstance] commandPrototypes] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end

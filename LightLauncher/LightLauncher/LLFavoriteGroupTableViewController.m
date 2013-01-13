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
#import "Receipt.h"

#import "UIViewController+ShowHUD.h"
#import "UIViewController+SetupSideMenu.h"

@interface LLFavoriteGroupTableViewController ()
- (void)updateCell:(LLFavoriteGroupCell *)cell atIndexPath:(NSIndexPath *)indexPath;
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
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        [self showErrorHUDWithTitle:@"Error" andDesc:[error localizedDescription]];
    }
}

- (void)dealloc {
    self.fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [Group MR_requestAllSortedBy:@"name" ascending:YES];
    [request setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext MR_contextForCurrentThread] sectionNameKeyPath:@"name" cacheName:@"Root"];
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFavoriteGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_GROUP_CELL forIndexPath:indexPath];
    [self updateCell:cell atIndexPath:indexPath];
    
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

- (void)onFinishedCommand:(LLCommand *)command {
    [self showExecutedCommandHUD];
}

- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self showErrorHUDWithTitle:title andDesc:desc];
}

#pragma mark - Favorite receipt cell delegate

- (void)onTappedReciept:(Receipt *)receipt {
    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self andDelegate:self];
}

#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self updateCell:(LLFavoriteGroupCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:sectionIndex];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:sections withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:sections withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Instance methods

- (void)updateCell:(LLFavoriteGroupCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Group *group = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell updateViewWithGroup:group andDelegate:self];
}

@end

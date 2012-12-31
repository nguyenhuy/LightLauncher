//
//  LLHistoryTableViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryTableViewController.h"
#import "LLCreateCommandTableViewController.h"

#import "LLCommandManager.h"
#import "LLCommandParser.h"

#import "LLCommandPrototype.h"

#import "Receipt.h"
#import "UIViewController+ShowHUD.h"
#import "UIViewController+SetupSideMenu.h"

@interface LLHistoryTableViewController ()
- (void)showRightEditBarButtonItem;
- (void)showRightDoneBarButtonItem;
- (void)updateCell:(LLHistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath;
//@TODO remove this???
- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation LLHistoryTableViewController

+ (LLHistoryTableViewController *)newInstance {
    return [[LLHistoryTableViewController alloc] initWithNibName:@"LLHistoryTableViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"History";
    [self.tableView registerClass:[LLHistoryCell class] forCellReuseIdentifier:IDENTIFIER_HISTORY_CELL];
    [self setupSideMenu];
    [self showRightEditBarButtonItem];
    
    // Fetch al receipts
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Error occured
        [self showErrorHUDWithTitle:@"Error" andDesc:[error localizedDescription]];
    }
}

- (void)dealloc {
    self.likeReceiptHelper = nil;
    self.fetchedResultsController = nil;
}

#pragma mark - Overriden setters

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    // Sort by executedDate
    NSFetchRequest *fetchRequest = [Receipt MR_requestAllSortedBy:@"executedDate" ascending:NO];
    [fetchRequest setFetchBatchSize:20];
    
    // Group by stringFromExecutedDate
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[NSManagedObjectContext MR_contextForCurrentThread] sectionNameKeyPath:@"stringFromExecutedDate" cacheName:@"Root"];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LLHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_HISTORY_CELL forIndexPath:indexPath];
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self andDelegate:self];
    
    // don't need to call table view reload, since it's called in NSFetchedResultsControllerDelegate
    //@TODO test if the table view is updated
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteReceiptAtIndexPath:indexPath];
    }
}

#pragma mark - History cell delegate

- (void)onToggleGroupOfReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([receipt liked]) {
        // Unlike
        BOOL changed = [LLCommandManager removeGroupForReceipt:receipt];

        // don't need to call table view reload, since it's called in NSFetchedResultsControllerDelegate
        //@TODO test if the table view is updated
        
        if (!changed) {
            //@TODO got error. Show something
        }
    } else {
        // Like
        self.likeReceiptHelper = [[LLLikeReceiptHelper alloc] init];
        [self.likeReceiptHelper likeReceipt:receipt withDelegate:self];
    }
}

- (void)onDuplicateReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    LLCreateCommandTableViewController *controller = [[LLCreateCommandTableViewController alloc] initWithNibName:NIB_CREATE_COMMAND_VIEW_CONTROLLER bundle:nil];
    controller.commandPrototype = receipt.commandPrototype;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Like receipt helper delegate

- (void)onFinishedLiking:(Receipt *)receipt {
    self.likeReceiptHelper = nil;
    
    // don't need to call table view reload, since it's called in NSFetchedResultsControllerDelegate
    //@TODO test if the table view is updated
}

- (void)onFailedLiking:(Receipt *)receipt {
    self.likeReceiptHelper = nil;
    [self showErrorHUDWithTitle:@"Failed" andDesc:nil];
}

#pragma mark - Command delegate

- (void)onFinishedCommand:(id)command {
    [self showExecutedCommandHUD];
    
    // don't need to call table view reload, since it's called in NSFetchedResultsControllerDelegate
    //@TODO test if the table view is updated
}

- (void)onStoppedCommand:(id)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self showErrorHUDWithTitle:title andDesc:desc];
}

#pragma mark - Fetched results controller

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
            [self updateCell:(LLHistoryCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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

- (void)showRightEditBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
}

- (void)showRightDoneBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditting)];
}

- (void)updateCell:(LLHistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell updateViewWithReceipt:receipt atIndexPath:indexPath andDelegate:self];
}

- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    BOOL deleted = [LLCommandManager deleteReceipt:receipt];
    if (deleted) {
        // don't need to call table view reload, since it's called in NSFetchedResultsControllerDelegate
        //@TODO test if the table view is updated

        // Done editing if there is no more receipt
        if (self.fetchedResultsController.fetchedObjects.count == 0) {
            [self doneEditting];
        }
    } else {
        //@TODO log to Crittercism
        //@TODO may handle error here
    }
}

- (void)edit {
    [self.tableView setEditing:YES animated:YES];
    [self showRightDoneBarButtonItem];
}

- (void)doneEditting {
    [self.tableView setEditing:NO animated:YES];
    [self showRightEditBarButtonItem];
}

@end

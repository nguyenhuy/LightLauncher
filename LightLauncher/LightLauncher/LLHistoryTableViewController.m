//
//  LLHistoryTableViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryTableViewController.h"

#import "LLCommandManager.h"
#import "LLCommandParser.h"

#import "LLCommandPrototype.h"

#import "Receipt.h"

@interface LLHistoryTableViewController ()
- (void)showRightEditBarButtonItem;
- (void)showRightDoneBarButtonItem;
- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation LLHistoryTableViewController

+ (LLHistoryTableViewController *)newInstance {
    return [[LLHistoryTableViewController alloc] initWithNibName:@"LLHistoryTableViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.title = @"History";
    [self.tableView registerClass:[LLHistoryCell class] forCellReuseIdentifier:IDENTIFIER_HISTORY_CELL];
    
    //@TODO may abstract this.
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
        
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reveal", @"Reveal") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
    
    [self showRightEditBarButtonItem];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LLCommandManager receipts].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Receipt *receipt = [[LLCommandManager receipts] objectAtIndex:indexPath.row];
    //@TODO parse the receipt.data here. Shall we???
    receipt.commandPrototype = [LLCommandParser decode:receipt.data];
    
    LLHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_HISTORY_CELL forIndexPath:indexPath];
    [cell updateViewWithReceipt:receipt atIndexPath:indexPath andDelegate:self];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Execute the command
    Receipt *receipt = [[LLCommandManager receipts] objectAtIndex:indexPath.row];
    // The data is already parsed in self:tableView:cellForRowAtIndexPath:, so don't need to parse here
    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteReceiptAtIndexPath:indexPath];
    }
}

#pragma mark - History cell delegate

- (void)onLikeReceiptAtIndexPath:(NSIndexPath *)indexPath {
    BOOL changed = [[LLCommandManager sharedInstance] toggleLikeOfReceiptAtIndex:indexPath.row];
    
    if (changed) {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
    }
}

#pragma mark - Instance methods

- (void)showRightEditBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
}

- (void)showRightDoneBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditting)];
}

- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath {
    BOOL deleted = [[LLCommandManager sharedInstance] deleteReceiptAtIndex:indexPath.row];
    if (deleted) {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Done editing if there is no more receipt
        if ([[LLCommandManager receipts] count] == 0) {
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

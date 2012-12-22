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
- (void)askDescForReceiptAtIndexPath:(NSIndexPath *)indexPath;
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
    
    //@TODO may abstract this.
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
        
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reveal", @"Reveal") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
    
    [self showRightEditBarButtonItem];
    
    self.receipts = [LLCommandManager loadReceiptsFromDB];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.receipts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
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
    
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];

    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self];
    
    // Load again from DB
    //@TODO may use model observer for CommandManager
    self.receipts = [LLCommandManager loadReceiptsFromDB];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteReceiptAtIndexPath:indexPath];
    }
}

#pragma mark - History cell delegate

- (void)onToggleGroupOfReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    if ([receipt liked]) {
        // Unlike
        BOOL changed = [LLCommandManager removeGroupForReceipt:receipt];
        if (changed) {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
        }
    } else {
        // Like
        [self askDescForReceiptAtIndexPath:indexPath];
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
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    BOOL deleted = [LLCommandManager deleteReceipt:receipt];
    if (deleted) {
        // Load again from DB
        self.receipts = [LLCommandManager loadReceiptsFromDB];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Done editing if there is no more receipt
        if (!self.receipts || self.receipts.count == 0) {
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

- (void)askDescForReceiptAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Description:" message:@"Enter description for the command" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    // Use tag to remember index of the receipt for now. Later if we show more alert views, may consider to use a property.
    alertView.tag = indexPath.row;
    [alertView show];
}

#pragma mark - Alert View delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // Only 1 alert view (ask receipt desc) is showed for now, so don't need to check the tag
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Done"]) {
        UITextField *descTextField = [alertView textFieldAtIndex:0];
        NSString *desc = descTextField.text;
        
        int index  = alertView.tag;
        Receipt *receipt = [self.receipts objectAtIndex:index];
        
        BOOL changed = [LLCommandManager assignDefaultGroupForReceipt:receipt withDescription:desc];
        if (changed) {
            // There is only section, so 0 is hardcoded here
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
        }
    }
}

@end

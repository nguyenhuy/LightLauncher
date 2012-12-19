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
- (void)loadReceipts;
- (void)showRightEditBarButtonItem;
- (void)showRightDoneBarButtonItem;
- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation LLHistoryTableViewController

+ (LLHistoryTableViewController *)newInstance {
    return [[LLHistoryTableViewController alloc] initWithNibName:@"LLHistoryTableViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //@TODO may reload all receipts in viewDidLoad or viewWillAppear
        [self loadReceipts];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    // Execute the command
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    //@TODO the data is parsed in LLCommandManager, after loading from db so no need to parse here
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
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    BOOL liked = [receipt.liked boolValue];
    receipt.liked = [NSNumber numberWithBool:!liked];

    if ([LLCommandManager save]) {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
    }
}

#pragma mark - Instance methods

- (void)loadReceipts {
    NSArray *temp = [LLCommandManager loadReceiptsFromDB];
    self.receipts = [NSMutableArray arrayWithArray:temp];
}

- (void)showRightEditBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
}

- (void)showRightDoneBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditting)];
}

- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath {
    BOOL deleted = [LLCommandManager deleteReceipt:[self.receipts objectAtIndex:indexPath.row]];
    if (deleted) {
        [self.receipts removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Done editing if there is no more receipt
        if (self.receipts.count == 0) {
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

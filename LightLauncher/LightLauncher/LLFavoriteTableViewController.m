//
//  LLFavoriteViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteTableViewController.h"

#import "LLCommandManager.h"
#import "LLCommandParser.h"

#import "LLFavoriteCell.h"

#import "Receipt.h"

@interface LLFavoriteTableViewController ()

@end

@implementation LLFavoriteTableViewController

+ (LLFavoriteTableViewController *)newInstance {
    return [[LLFavoriteTableViewController alloc] initWithNibName:@"LLFavoriteTableViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Favorite";
    [self.tableView registerClass:[LLFavoriteCell class] forCellReuseIdentifier:IDENTIFIER_FAVORITE_CELL];

    //@TODO may abstract this.
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
        
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reveal", @"Reveal") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LLCommandManager favReceipts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Receipt *receipt = [[LLCommandManager favReceipts] objectAtIndex:indexPath.row];
    //@TODO parse the receipt.data here. Shall we???
    receipt.commandPrototype = [LLCommandParser decode:receipt.data];

    LLFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_CELL forIndexPath:indexPath];
    [cell updateViewWithReceipt:receipt];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Execute the command
    Receipt *receipt = [[LLCommandManager favReceipts] objectAtIndex:indexPath.row];
    // The data is already parsed in self:tableView:cellForRowAtIndexPath:, so don't need to parse here
    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self];
}

@end

//
//  LLViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLViewController.h"
#import "LLReceiptManager.h"
#import "LLCommandCell.h"
#import "LLCommand.h"

@interface LLViewController ()
@end

@implementation LLViewController

@synthesize receiptManager = _receiptManager;
@synthesize headerView = _headerView;
@synthesize textFieldCommand = _textFieldCommand;
@synthesize statusView = _statusView;
@synthesize lblStatus = _lblStatus;
@synthesize tableView = _tableView;
@synthesize swipeGestureRecognizerStatusView = _swipeGestureRecognizerStatusView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.receiptManager = [[LLReceiptManager alloc] init];

    // Config swipe gesture recognizer for status view
    self.swipeGestureRecognizerStatusView.direction = UISwipeGestureRecognizerDirectionLeft & UISwipeGestureRecognizerDirectionRight;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setHeaderView:nil];
    [self setTextFieldCommand:nil];
    [self setStatusView:nil];
    [self setLblStatus:nil];
    [self setSwipeGestureRecognizerStatusView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITableViewCellDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LLCommandCell instanceWithCommand:[self.receiptManager.commands objectAtIndex:indexPath.row]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.receiptManager.commands count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self.receiptManager.commands objectAtIndex:indexPath.row] executeFromViewController:self];
}

#pragma mark - SwipeGestureRecognizerDelegate

- (IBAction)onSwipeStatusView:(id)sender {

}

@end

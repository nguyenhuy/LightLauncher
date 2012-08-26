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
@synthesize textFieldInput = _textFieldInput;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.receiptManager = [[LLReceiptManager alloc] init];
}

- (void)viewDidUnload
{
    [self setTextFieldInput:nil];
    [self setTableView:nil];
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

@end

//
//  LLGroupCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"
#import "LLFavoriteReceiptCell.h"
#import "LLCommandManager.h"
#import "LLCommandParser.h"
#import "Group.h"
#import "Receipt.h"

@implementation LLFavoriteGroupCell

- (void)updateViewWithGroup:(Group *)group andDelegate:(id<LLFavoriteGroupCellDelegate>)delegate {
    self.delegate = delegate;
    self.group = group;
    
    // Sort receipts
    NSSortDescriptor *sortDesctiptor = [[NSSortDescriptor alloc] initWithKey:@"executedDate" ascending:YES];
    self.receipts = [self.group.receipts sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesctiptor]];
    
    [self.tableViewInsideCell registerNib:[UINib nibWithNibName:NIB_FAVORITE_RECEIPT_CELL bundle:nil] forCellReuseIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL];

    CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableViewInsideCell.transform = rotateTable;
    self.tableViewInsideCell.frame = CGRectMake(0, 0, self.tableViewInsideCell.frame.size.width, self.tableViewInsideCell.frame.size.height);
    
    [self.tableViewInsideCell reloadData];
}

- (void)dealloc {
    // self and tableViewInsideCell points to each other, release connections here
    self.tableViewInsideCell.dataSource = nil;
    self.tableViewInsideCell.delegate = nil;
    self.tableViewInsideCell = nil;
    // Doesn't hurt anything :D
    self.delegate = nil;
    self.group = nil;
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.receipts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
    LLFavoriteReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL forIndexPath:indexPath];
    [cell updateViewWithCommandPrototype:receipt.commandPrototype];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Execute the command
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    UIViewController *viewController = [self.delegate viewControllerToExecuteCommand];

    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:viewController];
}

@end

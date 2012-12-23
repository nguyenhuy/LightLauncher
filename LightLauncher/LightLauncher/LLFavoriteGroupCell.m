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

@interface LLFavoriteGroupCell ()
@end

@implementation LLFavoriteGroupCell

- (void)updateViewWithGroup:(Group *)group andDelegate:(id<LLFavoriteGroupCellDelegate>)delegate {
    self.delegate = delegate;
    self.group = group;
    
    // Sort receipts
    NSSortDescriptor *sortDesctiptor = [[NSSortDescriptor alloc] initWithKey:@"executedDate" ascending:NO];
    self.receipts = [self.group.receipts sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesctiptor]];

    // Can't do these things in setup ???
    self.tableViewInsideCell.showsHorizontalScrollIndicator = NO;
    self.tableViewInsideCell.showsVerticalScrollIndicator = NO;
    [self.tableViewInsideCell registerClass:[LLFavoriteReceiptCell class] forCellReuseIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL];
    self.tableViewInsideCell.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.receipts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
    LLFavoriteReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL forIndexPath:indexPath];
    [cell updateViewWithCommandPrototype:receipt.commandPrototype atIndexPath:indexPath withDelegate:self];
    
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

#pragma mark - Favorite receipt cell delegate

- (void)onEditReceiptAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Edit now");
}

@end

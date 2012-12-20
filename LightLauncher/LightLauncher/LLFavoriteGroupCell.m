//
//  LLGroupCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"
#import "LLFavoriteReceiptCell.h"
#import "LLCommandParser.h"
#import "Receipt.h"

@implementation LLFavoriteGroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.tableViewInsideCell registerNib:[UINib nibWithNibName:NIB_FAVORITE_RECEIPT_CELL bundle:nil] forCellReuseIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL];
    }
    return self;
}

- (void)updateViewWithReceipts:(NSArray *)receipts {
    self.receipts = receipts;
    [self.tableViewInsideCell reloadData];
}

- (void)dealloc {
    // self and tableViewInsideCell points to each other, release connections here
    self.tableViewInsideCell.dataSource = nil;
    self.tableViewInsideCell.delegate = nil;
    self.tableViewInsideCell = nil;
    // Doesn't hurt anything :D
    self.receipts = nil;
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
    //@TODO should we parse it here???
    receipt.commandPrototype = [LLCommandParser decode:receipt.data
     ];
    
    LLFavoriteReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL forIndexPath:indexPath];
    [cell updateViewWithCommandPrototype:receipt.commandPrototype];
    
    return cell;
}

@end

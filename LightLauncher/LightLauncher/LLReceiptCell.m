//
//  LLReceiptCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLReceiptCell.h"

@implementation LLReceiptCell

+ (LLReceiptCell *)instanceWithReceipt:(LLReceipt *)receipt {
    LLReceiptCell *cell = [[LLReceiptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RECEIPT_CELL_IDENTIFIER];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

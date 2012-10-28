//
//  LLReceiptCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDENTIFIER_RECEIPT_CELL @"ReceiptCell"

@class LLReceipt;

@interface LLReceiptCell : UITableViewCell

- (void)setReceipt:(LLReceipt *)receipt;

@end

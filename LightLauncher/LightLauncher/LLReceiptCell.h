//
//  LLReceiptCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RECEIPT_CELL_IDENTIFIER @"ReceiptCell"

@class LLReceipt;

@interface LLReceiptCell : UITableViewCell

+(LLReceiptCell *)instanceWithReceipt:(LLReceipt *)receipt;

@end

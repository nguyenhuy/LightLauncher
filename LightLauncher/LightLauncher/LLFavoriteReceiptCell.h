//
//  LLFavoriteReceiptCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#define IDENTIFIER_FAVORITE_RECEIPT_CELL @"LLFavoriteReceiptCell"
#define WIDTH_FAVORITE_RECEIPT_CELL 100
#define HEIGHT_FAVORITE_RECEIPT_CELL 100

@class LLCommandPrototype;

@interface LLFavoriteReceiptCell : UITableViewCell

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype;

@end

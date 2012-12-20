//
//  LLFavoriteReceiptCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#define NIB_FAVORITE_RECEIPT_CELL @"LLFavoriteReceiptCell"
#define IDENTIFIER_FAVORITE_RECEIPT_CELL @"LLFavoriteReceiptCell"

@class LLCommandPrototype;

// Size is 64x64
//@TODO maybe the size is too small
@interface LLFavoriteReceiptCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype;

@end

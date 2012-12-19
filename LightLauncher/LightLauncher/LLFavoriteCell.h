//
//  LLFavoriteCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDENTIFIER_FAVORITE_CELL @"LLFavoriteCell"

@class Receipt;

@interface LLFavoriteCell : UITableViewCell

- (void)updateViewWithReceipt:(Receipt *)receipt;

@end

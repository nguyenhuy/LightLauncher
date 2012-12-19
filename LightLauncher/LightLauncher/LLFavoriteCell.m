//
//  LLFavoriteCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteCell.h"
#import "Receipt.h"
#import "LLCommandPrototype.h"

@implementation LLFavoriteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)updateViewWithReceipt:(Receipt *)receipt {
    //@TODO assume that receipt.data is parsed before hand
    self.imageView.image = [UIImage imageNamed:receipt.commandPrototype.iconFileName];
    self.textLabel.text = receipt.commandPrototype.desc;
}

@end

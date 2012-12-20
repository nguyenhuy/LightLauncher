//
//  LLFavoriteReceiptCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteReceiptCell.h"
#import "LLCommandPrototype.h"

@interface LLFavoriteReceiptCell ()
- (void)setup;
@end

@implementation LLFavoriteReceiptCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FAVORITE_RECEIPT_CELL, HEIGHT_FAVORITE_RECEIPT_CELL)];
    self.thumbnail.opaque = YES;
    
    [self.contentView addSubview:self.thumbnail];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.thumbnail.frame.size.height * 0.632, self.thumbnail.frame.size.width, self.thumbnail.frame.size.height * 0.37)];
    self.titleLabel.opaque = YES;
	self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0.4745098 blue:0.29019808 alpha:0.9];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    self.titleLabel.numberOfLines = 2;
    [self.thumbnail addSubview:self.titleLabel];
    
    self.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
}

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype {
    self.thumbnail.image = [UIImage imageNamed:commandPrototype.iconFileName];
    self.titleLabel.text = commandPrototype.desc;
}

@end

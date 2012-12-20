//
//  LLFavoriteReceiptCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteReceiptCell.h"
#import "LLCommandPrototype.h"

@implementation LLFavoriteReceiptCell

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype {
    self.imageView.image = [UIImage imageNamed:commandPrototype.iconFileName];
    self.textLabel.text = commandPrototype.desc;
}

@end

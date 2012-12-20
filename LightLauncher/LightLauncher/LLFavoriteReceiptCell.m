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
+ (void)rotateView:(UIView *)view;
@end

@implementation LLFavoriteReceiptCell

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype {
    self.imageView.image = [UIImage imageNamed:commandPrototype.iconFileName];
    self.textLabel.text = commandPrototype.desc;
    
    [LLFavoriteReceiptCell rotateView:self.imageView];
//    [LLFavoriteReceiptCell rotateView:self.textLabel];
}

+ (void)rotateView:(UIView *)view {
    view.contentMode = UIViewContentModeCenter;
    CGAffineTransform rotateImage = CGAffineTransformMakeRotation(M_PI_2);
    view.transform = rotateImage;
}

@end

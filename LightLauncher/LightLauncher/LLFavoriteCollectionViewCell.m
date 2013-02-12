//
//  LLFavoriteCollectionViewCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LLFavoriteCollectionViewCell.h"
#import "LLCommandPrototype.h"

@interface LLFavoriteCollectionViewCell ()
- (void)setupViews;
@end

@implementation LLFavoriteCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    float dim = MIN(self.bounds.size.width, self.bounds.size.height);
    float cornerRadius = dim / 20;
    
    self.title.layer.cornerRadius = cornerRadius;
    self.icon.layer.cornerRadius = cornerRadius;
}

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype atIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.icon.image = [UIImage imageNamed:commandPrototype.iconFileName];
    self.title.text = commandPrototype.desc;
}

@end

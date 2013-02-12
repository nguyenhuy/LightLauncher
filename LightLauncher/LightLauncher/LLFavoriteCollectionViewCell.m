//
//  LLFavoriteCollectionViewCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteCollectionViewCell.h"
#import "LLCommandPrototype.h"

@implementation LLFavoriteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype atIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.icon.image = [UIImage imageNamed:commandPrototype.iconFileName];
    self.title.text = commandPrototype.desc;
}

@end

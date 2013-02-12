//
//  LLFavoriteCollectionViewLayout.m
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteCollectionViewLayout.h"
#import "LLFavoriteCollectionViewLayoutAttributes.h"

@interface LLFavoriteCollectionViewLayout ()
- (BOOL)isDeletionModeOn;
@end

@implementation LLFavoriteCollectionViewLayout

+ (Class)layoutAttributesClass {
    return [LLFavoriteCollectionViewLayoutAttributes class];
}

- (BOOL)isDeletionModeOn {
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(LLFavoriteCollectionViewLayoutDelegate)]) {
        return [(id<LLFavoriteCollectionViewLayoutDelegate>) self.collectionView.delegate isDeletionModeActiveForCollectionView:self.collectionView andCollectionViewLayout:self];
    }
    return NO;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLFavoriteCollectionViewLayoutAttributes *attrs = (LLFavoriteCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    attrs.deleteButtonHidden = ![self isDeletionModeOn];
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    for (LLFavoriteCollectionViewLayoutAttributes *attrs in attributesArrayInRect) {
        attrs.deleteButtonHidden = ![self isDeletionModeOn];
    }
    return attributesArrayInRect;
}


@end

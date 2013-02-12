//
//  LLFavoriteCollectionViewLayout.h
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLFavoriteCollectionViewLayoutDelegate <NSObject>
- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView andCollectionViewLayout:(UICollectionViewLayout *)layout;
@end

@interface LLFavoriteCollectionViewLayout : UICollectionViewFlowLayout

@end

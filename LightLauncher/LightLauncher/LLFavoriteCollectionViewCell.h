//
//  LLFavoriteCollectionViewCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 2/12/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#define IDENTIFIER_FAVORITE_COLLECTION_VIEW_CELL @"FavoriteCollectionViewCell"
#define NIB_FAVORITE_COLLECTION_VIEW_CELL @"LLFavoriteCollectionViewCell"

@class LLCommandPrototype;
@class LLFavoriteCollectionViewCell;

@protocol LLFavoriteCollectionViewCellDelegate <NSObject>
- (void)onDelete:(LLFavoriteCollectionViewCell *)cell;
@end

@interface LLFavoriteCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<LLFavoriteCollectionViewCellDelegate> delegate;

- (void)updateViewWithCommandPrototype:(LLCommandPrototype *)commandPrototype atIndexPath:(NSIndexPath *)indexPath andDelegate:(id<LLFavoriteCollectionViewCellDelegate>)delegate;
- (IBAction)delete:(id)sender;

// Animations
- (void)startQuivering;
- (void)stopQuivering;

@end

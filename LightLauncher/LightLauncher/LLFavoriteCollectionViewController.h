//
//  LLFavoriteCollectionViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 2/10/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"
#import "LLFavoriteCollectionViewCell.h"
#import "LLFavoriteCollectionViewLayout.h"

@interface LLFavoriteCollectionViewController : UIViewController <LLCommandDelegate, NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, LLFavoriteCollectionViewCellDelegate, LLFavoriteCollectionViewLayoutDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) BOOL isDeletionModeActive;

+ (LLFavoriteCollectionViewController *)newInstance;

- (void)activateDeletionMode:(UILongPressGestureRecognizer *)gesture;
- (void)endDeletionMode:(UITapGestureRecognizer *)gesture;

@end

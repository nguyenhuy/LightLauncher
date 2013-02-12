//
//  LLFavoriteCollectionViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 2/10/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@interface LLFavoriteCollectionViewController : UIViewController <LLCommandDelegate, NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (LLFavoriteCollectionViewController *)newInstance;

@end

//
//  LLFavoriteCollectionViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 2/10/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteCollectionViewController.h"
#import "LLFavoriteCollectionViewCell.h"

#import "LLCommandManager.h"

#import "FavReceipt.h"

#import "UIViewController+SetupSideMenu.h"
#import "UIViewController+ShowHUD.h"

@interface LLFavoriteCollectionViewController ()
- (void)updateCell:(LLFavoriteCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation LLFavoriteCollectionViewController

+ (LLFavoriteCollectionViewController *)newInstance {
    return [[LLFavoriteCollectionViewController alloc] initWithNibName:@"LLFavoriteCollectionViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Favorite";

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NIB_FAVORITE_COLLECTION_VIEW_CELL bundle:nil] forCellWithReuseIdentifier:IDENTIFIER_FAVORITE_COLLECTION_VIEW_CELL];
    
    [self setupSideMenu];
    
    // Fetch FavReceipts
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        [self showErrorHUDWithTitle:@"Error" andDesc:[error localizedDescription]];
    }
}

- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    self.collectionView = nil;
    
    self.fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [FavReceipt MR_requestAllSortedBy:@"position" ascending:YES];
    [request setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext MR_contextForCurrentThread] sectionNameKeyPath:nil cacheName:@"Root"];
    return _fetchedResultsController;
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LLFavoriteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_FAVORITE_COLLECTION_VIEW_CELL forIndexPath:indexPath];
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    FavReceipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self andDelegate:self];
}

#pragma mark - Command Delegate

- (void)onFinishedCommand:(LLCommand *)command {
    [self showExecutedCommandHUD];
}

- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self showErrorHUDWithTitle:title andDesc:desc];
}

#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    //@TODO update this
//    [self.collectionView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self updateCell:(LLFavoriteCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
            break;
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:sectionIndex];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertSections:sections];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.collectionView deleteSections:sections];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //@TODO update this
//    [self.tableView endUpdates];
}

#pragma mark - Instance methods

- (void)updateCell:(LLFavoriteCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    FavReceipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell updateViewWithCommandPrototype:receipt.commandPrototype atIndexPath:indexPath];
}

@end

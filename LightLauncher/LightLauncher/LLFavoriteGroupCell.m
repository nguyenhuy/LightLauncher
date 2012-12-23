//
//  LLGroupCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLFavoriteGroupCell.h"
#import "LLFavoriteReceiptCell.h"
#import "LLCommandManager.h"
#import "LLCommandParser.h"
#import "Group.h"
#import "Receipt.h"
#import "DnDManager.h"

@interface LLFavoriteGroupCell ()
- (NSString *)overlayId;
@end

@implementation LLFavoriteGroupCell

- (void)updateViewWithGroup:(Group *)group andDelegate:(id<LLFavoriteGroupCellDelegate>)delegate {
    self.delegate = delegate;
    self.group = group;
    
    // Sort receipts
    NSSortDescriptor *sortDesctiptor = [[NSSortDescriptor alloc] initWithKey:@"executedDate" ascending:NO];
    self.receipts = [self.group.receipts sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesctiptor]];

    // Can't do these things in setup ???
    self.tableViewInsideCell.showsHorizontalScrollIndicator = NO;
    self.tableViewInsideCell.showsVerticalScrollIndicator = NO;
    [self.tableViewInsideCell registerClass:[LLFavoriteReceiptCell class] forCellReuseIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL];
    self.tableViewInsideCell.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    self.tableViewInsideCell.frame = CGRectMake(0, 0, self.tableViewInsideCell.frame.size.width, self.tableViewInsideCell.frame.size.height);
   
    [self.tableViewInsideCell reloadData];
}

- (NSString *)overlayId {
    //@TODO check if this need to be unique across groups
    return @"1";
}

- (void)dealloc {
    [[DnDManager instance] deregisterDnDItem:self fromOverlayId:[self overlayId]];
    // self and tableViewInsideCell points to each other, release connections here
    self.tableViewInsideCell.dataSource = nil;
    self.tableViewInsideCell.delegate = nil;
    self.tableViewInsideCell = nil;
    // Doesn't hurt anything :D
    self.delegate = nil;
    self.group = nil;
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.receipts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
    LLFavoriteReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_FAVORITE_RECEIPT_CELL forIndexPath:indexPath];
    [cell updateViewWithCommandPrototype:receipt.commandPrototype atIndexPath:indexPath withDelegate:self];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Execute the command
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    UIViewController *viewController = [self.delegate viewControllerToExecuteCommand];

    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:viewController];
}

#pragma mark - Favorite receipt cell delegate

- (void)onEditReceiptAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Edit now");
}

#pragma mark - DragSource delegate

- (UIView*)popItemForDragFrom:(CGPoint)point {
    // Find the cell under the touch point.
    NSIndexPath* indexPath = [self.tableViewInsideCell indexPathForRowAtPoint:point];
    LLFavoriteReceiptCell* cell = (LLFavoriteReceiptCell *)[self.tableViewInsideCell cellForRowAtIndexPath:indexPath];
    if( cell == nil ) return nil;
    
    // Return a copy of the cell, then delete the cell from the table.
    //
    // We can't just return the cell itself, because it'll still be controlled by the table while
    // the delete animation is going on. So we create & return a copy instead.
    // @TODO clone the view here
//    UIView* cellCopy = [self createViewForDragFrom:cell];

    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    // Save the receipt temtporatery, should remove it in droppedAtPoint:
    cell.tempReceipt = receipt;
    //Remove the group of receipt
    [LLCommandManager removeGroupForReceipt:receipt];
    [self.receipts removeObject:receipt];
    [self.tableViewInsideCell deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    return cell;
}

#pragma mark - DropTarget methods

// This gives you a chance to filter what type of draggable objects you accept.
- (BOOL)acceptsDraggable:(UIView *)draggable {
    return YES;
}

// Returns the center of the table row where an item hovered at this point would be dropped.
- (CGPoint)actualDropPointForLocation:(CGPoint)point {
    NSIndexPath* newIndexPath = [self.tableViewInsideCell indexPathForRowAtPoint:point];
    // If the point is past the last cell, return the rectangle of the last cell (which
    // will be the placeholder)
    if( newIndexPath == nil ) newIndexPath = [NSIndexPath indexPathForRow:(self.receipts.count -1) inSection:0];
    
    CGRect rowRect = [self.tableViewInsideCell rectForRowAtIndexPath:newIndexPath];
    return CGPointMake( CGRectGetMidX( rowRect ), CGRectGetMidY( rowRect ));
}

// Insert a placeholder at the appropriate row to show where the draggable would
// be dropped.
- (void)draggable:(UIView *)draggable enteredAtPoint:(CGPoint)point {
    NSIndexPath* newIndexPath = [self.tableViewInsideCell indexPathForRowAtPoint:point];
    if( newIndexPath == nil ) newIndexPath = [NSIndexPath indexPathForRow:self.receipts.count inSection:0];
    
    // Temporatery insert data and the cell here
    [self.receipts insertObject:nil atIndex:newIndexPath.row];
    [self.tableViewInsideCell insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    self.hoveringIndexPath = newIndexPath;
}

// Move the placeholder if necessary.
- (void)draggable:(UIView*)draggable hoveringAtPoint:(CGPoint)point {
    NSIndexPath* newIndexPath = [self.tableViewInsideCell indexPathForRowAtPoint:point];
    // If row is past the last cell, use the last cell (because we don't want to add a new cell,
    // just remove the existing placeholder to the end)
    if( newIndexPath == nil ) newIndexPath = [NSIndexPath indexPathForRow:(self.receipts.count -1) inSection:0];
    
    // If the draggable is still over the same row, do nothing.  If it's moved up or down, move the
    // placeholder to the appropriate row.
    if( newIndexPath.row != self.hoveringIndexPath.row ) {
        [self.receipts removeObjectAtIndex:newIndexPath.row];
        [self.tableViewInsideCell deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.hoveringIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.receipts insertObject:nil atIndex:newIndexPath.row];
        [self.tableViewInsideCell insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        self.hoveringIndexPath = newIndexPath;
    }
}

// Get rid of the placeholder.
- (void)draggableExited:(UIView*)draggable {
    [self.receipts removeObjectAtIndex:self.hoveringIndexPath.row];
    [self.tableViewInsideCell deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.hoveringIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    self.hoveringIndexPath = nil;
}

// Remove the placeholder and insert the dragged item.
- (void)draggable:(UIView*)draggable droppedAtPoint:(CGPoint)point {
    if( self.hoveringIndexPath != nil ) {
        [self.receipts removeObjectAtIndex:self.hoveringIndexPath.row];
        [self.tableViewInsideCell deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.hoveringIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.hoveringIndexPath = nil;
    }
    
    NSIndexPath* newIndexPath = [self.tableViewInsideCell indexPathForRowAtPoint:point];
    if( newIndexPath == nil ) {
        newIndexPath = [NSIndexPath indexPathForRow:self.receipts.count inSection:0];
    }
    
    NSLog( @"Dropping object at row %d", newIndexPath.row );
    
    LLFavoriteReceiptCell* draggedCell = (LLFavoriteReceiptCell *)draggable;
    [self.receipts insertObject:draggedCell.tempReceipt atIndex:newIndexPath.row];
    [self.tableViewInsideCell insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    draggedCell.tempReceipt = nil;
}

@end

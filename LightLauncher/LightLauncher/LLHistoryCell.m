//
//  LLHistoryCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/19/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryCell.h"
#import "LLCommandPrototype.h"
#import "HistoryReceipt.h"

@implementation LLHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Swipe right regconizer for the cell, to show the menu
        UISwipeGestureRecognizer *reg = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onShowSwipeSideMenu)];
        reg.direction = UISwipeGestureRecognizerDirectionRight;
        self.gestureRecognizers = [NSArray arrayWithObject:reg];
        
        // Init the menu
        self.menu = [LLSideSwipeMenu newInstanceWithDelegate:self];
    }
    return self;
}

- (void)updateViewWithHistoryReceipt:(HistoryReceipt *)receipt atIndexPath:(NSIndexPath *)indexPath andDelegate:(id<LLHistoryCellDelegate>)delegate {
    if (!receipt) {
        return;
    }
    
    self.indexPath = indexPath;
    self.delegate = delegate;
    self.textLabel.text = receipt.commandPrototype.desc;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    self.detailTextLabel.text = [dateFormatter stringFromDate:receipt.executedDate];
    
    [self.menu updateViewWithReceipt:receipt];
}

- (void)dealloc {
    self.delegate = nil;
    self.menu = nil;
}

- (void)onShowSwipeSideMenu {
    [self insertSubview:self.menu aboveSubview:self.contentView];
    self.menu.alpha = 0.0;

    [UIView animateWithDuration:FADE_IN_DURATION
                     animations:^{
                         self.menu.alpha = 1;
                     }
     ];
}

#pragma mark - Side swipe menu delegate

- (void)onLike {
    [self.delegate onToggleGroupOfReceiptAtIndexPath:self.indexPath];
    [self onHideSideSwipeMenu];
}

- (void)onDuplicate {
    [self.delegate onDuplicateReceiptAtIndexPath:self.indexPath];
    [self onHideSideSwipeMenu];
}

- (void)onHideSideSwipeMenu {
    [UIView animateWithDuration:FADE_OUT_DURATION
                     animations:^{
                         self.menu.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [self.menu removeFromSuperview];
                     }
     ];
}

@end

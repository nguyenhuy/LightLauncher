//
//  LLSideSwipeMenu.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NIB_SIDE_SWIPE_MENU @"LLSideSwipeMenu"

@class Receipt;

@protocol LLSideSwipeMenuDelegate <NSObject>

- (void)onLike;
- (void)onDuplicate;
- (void)onHideSideSwipeMenu;

@end

@interface LLSideSwipeMenu : UIView

@property (strong, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) id<LLSideSwipeMenuDelegate> delegate;

+ (LLSideSwipeMenu *)newInstanceWithDelegate:(id<LLSideSwipeMenuDelegate>)delegate;

- (void)updateViewWithReceipt:(Receipt *)receipt;
- (IBAction)like:(id)sender;
- (IBAction)duplicate:(id)sender;
- (void)onSwipe;

@end

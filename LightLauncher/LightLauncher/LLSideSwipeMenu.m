//
//  LLSideSwipeMenu.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLSideSwipeMenu.h"
#import "Receipt.h"

@implementation LLSideSwipeMenu

+ (LLSideSwipeMenu *)newInstanceWithDelegate:(id)delegate {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NIB_SIDE_SWIPE_MENU owner:nil options:nil];
    LLSideSwipeMenu *menu = [views objectAtIndex:0];
    menu.delegate = delegate;
    return menu;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        
        self.gestureRecognizers = [NSArray arrayWithObjects:swipeLeft, swipeRight, tap, nil];
    }
    return self;
}

- (void)updateViewWithReceipt:(Receipt *)receipt {
    UIImage *likeImage = [UIImage imageNamed:IMAGE_LIKE_UNSELECTED];
    [self.btnLike setImage:likeImage forState:UIControlStateNormal];
}

- (IBAction)like:(id)sender {
    [self.delegate onLike];
}

- (IBAction)duplicate:(id)sender {
    [self.delegate onDuplicate];
}

- (void)hide {
    [self.delegate onHideSideSwipeMenu];
}

- (void)dealloc {
    self.gestureRecognizers = nil;
    self.delegate = nil;
    self.btnLike = nil;
}

@end

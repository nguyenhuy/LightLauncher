//
//  UIView+FadeAnimation.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "UIView+FadeAnimations.h"

@implementation UIView (FadeAnimations)

- (void)fadeIn {
    // Fade in the menu
    [self setAlpha:0.0];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:FADE_ANIMATIONS_DURATION];
    [self setAlpha:1.0];
    [UIView commitAnimations];
}

- (void)fadeOut {
    // Fade in the menu
    [self setAlpha:1.0];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:FADE_ANIMATIONS_DURATION];
    [self setAlpha:0.0];
    [UIView commitAnimations];
}

@end

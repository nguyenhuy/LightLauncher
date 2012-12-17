//
//  LLRevealController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLRevealController.h"

@implementation LLRevealController

- (id)initWithFrontViewController:(UIViewController *)aFrontViewController rearViewController:(UIViewController *)aBackViewController {
    self = [super initWithFrontViewController:aFrontViewController rearViewController:aBackViewController];
    if (self) {
        self.delegate = self;
        //@TODO is this a good place to set???
        self.showingGroup = GROUP_CREATE;
    }
    return self;
}

#pragma - ZUUIRevealControllerDelegate Protocol.

/*
 * All of the methods below are optional. You can use them to control the behavior of the ZUUIRevealController,
 * or react to certain events.
 */
- (BOOL)revealController:(ZUUIRevealController *)revealController shouldRevealRearViewController:(UIViewController *)rearViewController
{
	return YES;
}

- (BOOL)revealController:(ZUUIRevealController *)revealController shouldHideRearViewController:(UIViewController *)rearViewController
{
	return YES;
}

@end

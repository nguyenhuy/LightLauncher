//
//  LLRevealController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@interface LLRevealController : ZUUIRevealController <ZUUIRevealControllerDelegate>

// Keeps track of ViewControllerGroup is showing in front
// This should be determined by this RevealController isself via delegate methods.
// However, for now, it's set by RearViewController because it's easier.
@property (nonatomic, readwrite) ViewControllerGroup showingGroup;

- (void)showCreateGroup;
- (void)showHistoryGroup;
- (void)showFavoriteGroup;

@end

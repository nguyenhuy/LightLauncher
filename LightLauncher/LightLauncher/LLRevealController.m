//
//  LLRevealController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLRevealController.h"

#import "LLCommandPrototypeTableViewController.h"
#import "LLHistoryTableViewController.h"

@interface LLRevealController ()
@end

@implementation LLRevealController

- (id)initWithFrontViewController:(UIViewController *)aFrontViewController rearViewController:(UIViewController *)aBackViewController {
    self = [super initWithFrontViewController:aFrontViewController rearViewController:aBackViewController];
    if (self) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - ZUUIRevealControllerDelegate Protocol.

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

#pragma mark - Instance methods

- (void)showCreateGroup {
    if (self.showingGroup == GROUP_CREATE) {
        // Showing the same group. Toggle the view instead.
        [self revealToggle:self];
    } else {
        LLCommandPrototypeTableViewController *controller = [LLCommandPrototypeTableViewController newInstance];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self setFrontViewController:navigationController];
        self.showingGroup = GROUP_CREATE;
    }
}

- (void)showHistoryGroup {
    if (self.showingGroup == GROUP_HISTORY) {
        // Showing the same group. Toggle the view instead.
        [self revealToggle:self];
    } else {
        LLHistoryTableViewController *controller = [LLHistoryTableViewController newInstance];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self setFrontViewController:navigationController];
        self.showingGroup = GROUP_HISTORY;
    }
}

- (void)showFavoriteGroup {
    if (self.showingGroup == GROUP_FAVORITE) {
        // Showing the same group. Toggle the view instead.
        [self revealToggle:self];
    } else {
        //@TODO change this to show FAVORITE view
        LLCommandPrototypeTableViewController *controller = [LLCommandPrototypeTableViewController newInstance];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self setFrontViewController:navigationController];
        self.showingGroup = GROUP_FAVORITE;
    }
}

@end

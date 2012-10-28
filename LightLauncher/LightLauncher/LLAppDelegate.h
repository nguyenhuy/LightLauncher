//
//  LLAppDelegate.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLCommandPrototypeTableViewController;

@interface LLAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) LLCommandPrototypeTableViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

//
//  LLAppDelegate.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLRevealController;
@class GPPShare;

@interface LLAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) LLRevealController *revealController;
@property (retain, nonatomic) GPPShare *share;

+ (LLAppDelegate *)sharedInstance;

- (void)ensureGppShare;

@end

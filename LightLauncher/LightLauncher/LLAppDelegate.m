//
//  LLAppDelegate.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLAppDelegate.h"
#import "LLFavoriteGroupTableViewController.h"
#import "LLRearViewController.h"
#import "LLRevealController.h"
#import "GPPShare.h"

@implementation LLAppDelegate

+ (LLAppDelegate *)sharedInstance {
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"LightLauncher.sqlite"];
    
    LLFavoriteGroupTableViewController *frontViewController = [LLFavoriteGroupTableViewController newInstance];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    LLRearViewController *rearViewController = [LLRearViewController newInstance];

    self.revealController = [[LLRevealController alloc] initWithFrontViewController:navigationController rearViewController:rearViewController];
    self.revealController.showingGroup = GROUP_FAVORITE;
    
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([self.share handleURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }
    return NO;
}

#pragma mark Google Plus

- (void)ensureGppShare {
    if (!self.share) {
        self.share = [[GPPShare alloc] initWithClientID:CLIENT_ID_GOOGLE_PLUS];
    }
}

@end

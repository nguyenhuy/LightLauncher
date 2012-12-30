//
//  UIViewController+ShowHUD.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;

@interface UIViewController (ShowHUD)

- (MBProgressHUD *)showAutoHideHUD;
- (MBProgressHUD *)showCheckmarkHUDWithLabelText:(NSString *)labelText;
- (MBProgressHUD *)showExecutedCommandHUD;
- (MBProgressHUD *)showTextHUDWithLabelText:(NSString *)labelText;
- (MBProgressHUD *)showErrorHUDWithTitle:(NSString *)title andDesc:(NSString *)desc;

@end

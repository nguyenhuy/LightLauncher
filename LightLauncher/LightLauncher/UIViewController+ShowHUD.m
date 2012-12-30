//
//  UIViewController+ShowHUD.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "UIViewController+ShowHUD.h"
#import "MBProgressHUD.h"

@implementation UIViewController (ShowHUD)

- (MBProgressHUD *)showAutoHideHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:HUD_DELAY_INTERVAL];
    return hud;
}

- (MBProgressHUD *)showCheckmarkHUDWithLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [self showAutoHideHUD];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMAGE_HUD_CHECKMARK] ];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = labelText;
    return hud;
}

- (MBProgressHUD *)showExecutedCommandHUD {
    return [self showCheckmarkHUDWithLabelText:@"Executed"];
}

- (MBProgressHUD *)showTextHUDWithLabelText:(NSString *)labelText {
    MBProgressHUD *hud = [self showAutoHideHUD];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    return hud;
}

- (MBProgressHUD *)showErrorHUDWithTitle:(NSString *)title andDesc:(NSString *)desc {
    MBProgressHUD *hud = [self showErrorHUDWithTitle:title andDesc:desc];
    hud.detailsLabelText = desc;
    return hud;
}

@end

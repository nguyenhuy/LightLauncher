//
//  LLInfoPanelView.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NIB_INFO_PANEL_VIEW @"LLInfoPanelView"

@interface LLInfoPanelView : UIView

@property (nonatomic) CGRect initialFrame;
@property (nonatomic) CGFloat initalScrollIndicatorHeight;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UITextField *timeLbl;
@property (strong, nonatomic) IBOutlet UITextField *dateLbl;

+ (LLInfoPanelView *)newInstance;

- (void)updateViewWithDate:(NSDate *)date;

@end

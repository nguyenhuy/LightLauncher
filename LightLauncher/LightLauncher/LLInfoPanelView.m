//
//  LLInfoPanelView.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLInfoPanelView.h"

@implementation LLInfoPanelView

+ (LLInfoPanelView *)newInstance {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NIB_INFO_PANEL_VIEW owner:nil options:nil];
    return [views objectAtIndex:0];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.initialFrame = CGRectMake(- self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.frame = self.initialFrame;        
    }
    return self;
}

- (void)updateViewWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterMediumStyle;
    self.timeLbl.text = [formatter stringFromDate:date];
    
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    self.dateLbl.text = [formatter stringFromDate:date];
}

@end

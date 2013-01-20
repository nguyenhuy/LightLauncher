//
//  HistoryReceipt.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/20/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "HistoryReceipt.h"


@implementation HistoryReceipt

@dynamic executedDate;

- (NSString *)stringFromExecutedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    return [formatter stringFromDate:self.executedDate];
}

@end

//
//  HistoryReceipt.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/20/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Receipt.h"

@interface HistoryReceipt : Receipt

@property (nonatomic, retain) NSDate * executedDate;

- (NSString *)stringFromExecutedDate;

@end

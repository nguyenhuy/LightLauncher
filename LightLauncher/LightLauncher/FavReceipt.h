//
//  FavReceipt.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/20/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Receipt.h"

@class Group;

@interface FavReceipt : Receipt

@property (nonatomic, retain) NSNumber * positionInGroup;
@property (nonatomic, retain) Group *group;

@end

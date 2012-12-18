//
//  Command.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/16/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <CoreData/CoreData.h>

#define ENTITY_NAME_RECEIPT @"Receipt"
#define ENTITY_KEY_EXECUTED_DATE @"executedDate"

@interface Receipt : NSManagedObject

@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSDate * executedDate;
@property (nonatomic, retain) NSNumber * liked;

@end

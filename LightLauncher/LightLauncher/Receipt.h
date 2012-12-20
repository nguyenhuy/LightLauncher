//
//  Receipt.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group;
@class LLCommandPrototype;

@interface Receipt : NSManagedObject

@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSDate *executedDate;
@property (nonatomic, retain) Group *group;

// Non-CoreData properties
@property (nonatomic, strong) LLCommandPrototype *commandPrototype;
- (BOOL)liked;

@end

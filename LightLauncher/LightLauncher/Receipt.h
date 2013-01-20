//
//  Receipt.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/20/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <CoreData/CoreData.h>

@class LLCommandPrototype;

@interface Receipt : NSManagedObject

@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSDate *executedDate;

// Non-CoreData properties
@property (nonatomic, strong) LLCommandPrototype *commandPrototype;

// Save desc of receipt to data and commandPrototype
// By decoding the data (if needed), save desc to commandPrototype and encode it again
- (void)setDesc:(NSString *)desc;
- (NSString *)stringFromExecutedDate;

@end

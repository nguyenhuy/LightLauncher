//
//  LLOptionValuePrototype.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/5/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface LLOptionValuePrototype : NSObject

@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, strong, readonly) NSString *displayName;
@property (nonatomic, readonly) OptionValueType type;


- (id)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName andType:(OptionValueType)type;

@end

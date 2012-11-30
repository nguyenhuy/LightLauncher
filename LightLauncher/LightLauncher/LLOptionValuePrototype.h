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
@property (nonatomic) BOOL selected;
@property (nonatomic, strong) id value;

- (LLOptionValuePrototype *)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName andType:(OptionValueType)type;
- (NSString *)valueString;

@end

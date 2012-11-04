//
//  LLOptionPrototype.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLOptionPrototype : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *displayName;
// Dictionary of possible values
// Key is the value
// Value is the display value, which is readable and should be used to display in UI
@property (nonatomic, strong) NSDictionary *possibleValues;

- (LLOptionPrototype *)initWithName:(NSString *)name andDisplayName:(NSString *)displayName andPossibleValues:(NSDictionary *)possibleValues;

@end

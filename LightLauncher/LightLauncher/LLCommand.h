//
//  LLCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class LLCommandPrototype;

@interface LLCommand : NSObject

@property (nonatomic, strong) NSMutableDictionary *options;

+ (LLCommandPrototype *)commandPrototype;
+ (NSString *)command;
+ (NSString *)description;
+ (NSString *)iconFileName;

- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;
// Add value to a new or existing array associates with the key
- (void)addValue:(id)value forKey:(NSString *)key;

- (void)executeFromViewController:(UIViewController *)viewController;

@end

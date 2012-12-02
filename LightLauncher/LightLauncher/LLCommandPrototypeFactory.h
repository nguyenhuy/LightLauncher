//
//  LLCommandPrototypeFactory.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLCommandPrototype;

@interface LLCommandPrototypeFactory : NSObject

+ (LLCommandPrototype *)commandPrototypeForCommand:(NSString *)command;
+ (LLCommandPrototype *)emailCommandPrototype;
+ (LLCommandPrototype *)facebookCommandPrototype;
+ (LLCommandPrototype *)twitterCommandPrototype;

@end

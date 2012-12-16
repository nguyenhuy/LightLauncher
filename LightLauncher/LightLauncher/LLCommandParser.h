//
//  LLCommandParser.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommandPrototype;

@interface LLCommandParser : NSObject

// Encode command prototype to json string
+ (NSString *)encode:(LLCommandPrototype *)commandPrototype;
// Decode json string that represents a command prototype
+ (LLCommandPrototype *)decode:(NSString *)json;

@end

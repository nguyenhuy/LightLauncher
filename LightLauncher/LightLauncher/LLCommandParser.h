//
//  LLCommandParser.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLCommand;

@interface LLCommandParser : NSObject

// Encode command to json string
+ (NSString *)encode:(LLCommand *)command;
// Decode json string that represents a command
+ (LLCommand *)decode:(NSString *)json;

@end

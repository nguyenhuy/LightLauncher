//
//  LLCommandCompiler.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLCommand;
@class LLCommandPrototype;

@interface LLCommandCompiler : NSObject

// Retruns a new command with compiled value for each option which represents in rawCommand
+ (LLCommand *)compile:(const LLCommand *)rawCommand withCommandPrototype:(LLCommandPrototype *)commandPrototype;

@end

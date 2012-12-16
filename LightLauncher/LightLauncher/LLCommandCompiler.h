//
//  LLCommandCompiler.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommand;
@class LLCommandPrototype;

@interface LLCommandCompiler : NSObject

+ (LLCommand *)compile:(LLCommandPrototype *)commandPrototype;

@end

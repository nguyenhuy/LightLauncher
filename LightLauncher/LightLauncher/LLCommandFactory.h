//
//  LLCommandFactory.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/16/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommand;

@interface LLCommandFactory : NSObject

+ (LLCommand *)commandForString:(NSString *)command;

@end

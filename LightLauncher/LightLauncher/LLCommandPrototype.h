//
//  LLCommandPrototype.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/2/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommand;

@interface LLCommandPrototype : NSObject

@property (nonatomic, strong, readonly) NSString *command;
// An array of LLOptionPrototype
@property (nonatomic, strong, readonly) NSArray *options;

- (LLCommandPrototype *)initWithCommand:(NSString *)command andOptions:(NSArray *)options;

@end

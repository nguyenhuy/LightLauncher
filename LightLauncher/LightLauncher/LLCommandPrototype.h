//
//  LLCommandPrototype.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/2/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLCommand;

@interface LLCommandPrototype : NSObject

@property (nonatomic, strong) LLCommand *command;
// An array of LLOptionPrototype
@property (nonatomic, strong) NSArray *options;

- (LLCommandPrototype *)initWithCommand:(LLCommand *)command andOptions:(NSArray *)options;

@end

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
// An dictionary of options
// Key is name of the option
// Value is an array of possible values for that option
@property (nonatomic, strong) NSDictionary *options;

@end

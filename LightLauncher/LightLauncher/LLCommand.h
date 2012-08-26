//
//  LLCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLCommand : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSArray *options;

@end

//
//  LLCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLCommand : NSObject

@property (nonatomic, strong) NSString *command;
@property (nonatomic, strong) NSArray *options;

- initWithCommand:(NSString *)command AndOptions:(NSArray *)options;
- (NSString *)description;
- (NSString *)iconFileName;
- (void) executeFromViewController:(UIViewController *)viewController;

@end

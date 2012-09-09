//
//  LLCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLCommand : NSObject

@property (nonatomic, strong) NSString *name;

- (id)initWithName:(NSString *)name;
- (NSString *)description;
- (NSString *)iconFileName;
- (void) executeFromViewController:(UIViewController *)viewController;

@end

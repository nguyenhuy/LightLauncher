//
//  LLCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@implementation LLCommand

@synthesize name = _name;

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (NSString *)description {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"description must be implemented" userInfo:nil];
}

- (NSString *)iconFileName {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"iconFileName must be implemented" userInfo:nil];
}

- (void)executeFromViewController:(UIViewController *)viewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"execute must be implemented" userInfo:nil];
}

@end

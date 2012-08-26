//
//  LLCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@implementation LLCommand

@synthesize command = _command;
@synthesize options = _options;

- (id)initWithCommand:(NSString *)command AndOptions:(NSArray *)options {
    self = [super init];
    if (self != nil) {
        self.command = command;
        self.options = options;
    }
    return self;
}

- (NSString *)description {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"description must be implemented" userInfo:nil];
}

- (NSString *)iconFileName {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"iconFileName must be implemented" userInfo:nil];
}

- (void)executeWithNavigationController:(UINavigationController *)navigationController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"execute must be implemented" userInfo:nil];
}

@end

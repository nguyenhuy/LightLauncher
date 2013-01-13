//
//  LLCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@implementation LLCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    NSString *reason = [NSString stringWithFormat:@"setValue:forKey:%@ must be implemented", key, nil];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    self.delegate = delegate;
}

- (void)onFinished {
    [self.delegate onFinishedCommand:self];
    self.delegate = nil;
}

- (void)onCanceled {
    [self.delegate onCanceledCommand:self];
    self.delegate = nil;
}

- (void)onErrorWithTitle:(NSString *)title andDesc:(NSString *)desc {
    [self.delegate onStoppedCommand:self withErrorTitle:title andErrorDesc:desc];
    self.delegate = nil;
}

@end

//
//  LLCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"

@interface LLCommand ()

@property (nonatomic, strong, readwrite) UIViewController *viewController;
@property (nonatomic, strong, readwrite) id<LLCommandDelegate> delegate;

- (void)cleanUpAfterExecuting;

@end

@implementation LLCommand

- (void)setValue:(id)value forKey:(NSString *)key {
    NSString *reason = [NSString stringWithFormat:@"setValue:forKey:%@ must be implemented", key, nil];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    self.delegate = delegate;
    self.viewController = viewController;
}

- (void)onFinished {
    [self.delegate onFinishedCommand:self];
    [self cleanUpAfterExecuting];
}

- (void)onCanceled {
    [self.delegate onCanceledCommand:self];
    [self cleanUpAfterExecuting];
}

- (void)onErrorWithTitle:(NSString *)title andDesc:(NSString *)desc {
    [self.delegate onStoppedCommand:self withErrorTitle:title andErrorDesc:desc];
    [self cleanUpAfterExecuting];
}

- (void)cleanUpAfterExecuting {
    self.delegate = nil;
    self.viewController = nil;
}

@end

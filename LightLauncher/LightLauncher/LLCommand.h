//
//  LLCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommandPrototype;
@class LLCommand;

@protocol LLCommandDelegate <NSObject>

- (void)onFinishedCommand:(LLCommand *)command;
- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc;

@optional
- (void)onCanceledCommand:(LLCommand *)command;

@end

@interface LLCommand : NSObject

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) id<LLCommandDelegate> delegate;

- (void)setValue:(id)value forKey:(NSString *)key;
- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>) delegate;
- (void)onFinished;
- (void)onCanceled;
- (void)onErrorWithTitle:(NSString *)title andDesc:(NSString *)desc;

@end

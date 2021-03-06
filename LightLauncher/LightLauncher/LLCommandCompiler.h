//
//  LLCommandCompiler.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommand;
@class LLCommandPrototype;
@class LLOptionPrototype;

@protocol LLCommandCompilerDelegate <NSObject>

- (void)onFinishedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withCompiledValue:(id)compiledValue;
// This is called whenever a option is failed to compiled. To make use of as most options as possible and ignore errors, this is called multiple times and at the end, onFinishedCompilingCommandPrototype:withCompiledValue is still called.
- (void)onFailedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withError:(NSError *)error;

@end

@interface LLCommandCompiler : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) LLCommandPrototype *compilingCommandPrototype;
@property (nonatomic, strong) LLCommand *compilingCommand;
@property (nonatomic, strong) LLOptionPrototype *compilingOption;
@property (nonatomic) int compilingCounter;
@property (nonatomic, weak) id<LLCommandCompilerDelegate> delegate;
@property (nonatomic, strong) UIViewController *viewController;

- (void)compile:(LLCommandPrototype *)commandPrototype withDelegate:(id<LLCommandCompilerDelegate>)delegate andViewController:(UIViewController *)viewController;

@end

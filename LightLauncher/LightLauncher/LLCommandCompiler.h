//
//  LLCommandCompiler.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommand;
@class LLCommandPrototype;

@protocol LLCommandCompilerDelegate <NSObject>

- (void)onFinishedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype withCompiledValue:(id)compiledValue;
- (void)onFailedCompilingCommandPrototype:(LLCommandPrototype *)commandPrototype;

@end

@interface LLCommandCompiler : NSObject

@property (nonatomic, strong) LLCommandPrototype *compilingCommandPrototype;
@property (nonatomic, strong) LLCommand *compilingCommand;
@property (nonatomic) int compilingCounter;
@property (nonatomic, weak) id<LLCommandCompilerDelegate> delegate;

- (void)compile:(LLCommandPrototype *)commandPrototype withDelegate:(id<LLCommandCompilerDelegate>)delegate;;

@end

//
//  LLAddFavoriteReceiptHelper.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLCommandPrototype;

@protocol LLLikeCommandHelperDelegate <NSObject>
- (void)onFinishedLiking;
- (void)onFailedLiking;
@end

@interface LLLikeCommandHelper : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong) LLCommandPrototype *commandPrototype;
@property (nonatomic, weak) id<LLLikeCommandHelperDelegate> delegate;

- (void)likeCommandPrototype:(LLCommandPrototype *)commandPrototype withDelegate:(id<LLLikeCommandHelperDelegate>)delegate;

@end

//
//  LLAddFavoriteReceiptHelper.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Receipt;

@protocol LLLikeReceiptHelperDelegate <NSObject>
- (void)onFinishedLiking:(Receipt *)receipt;
- (void)onFailedLiking:(Receipt *)receipt;
@end

@interface LLLikeReceiptHelper : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong) Receipt *receipt;
@property (nonatomic, weak) id<LLLikeReceiptHelperDelegate> delegate;

- (void)likeReceipt:(Receipt *)receipt withDelegate:(id<LLLikeReceiptHelperDelegate>)delegate;

@end

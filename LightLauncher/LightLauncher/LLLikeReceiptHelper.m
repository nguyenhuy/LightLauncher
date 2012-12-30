//
//  LLAddFavoriteReceiptHelper.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/30/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLLikeReceiptHelper.h"
#import "LLCommandManager.h"
#import "Receipt.h"

@implementation LLLikeReceiptHelper

- (void)likeReceipt:(Receipt *)receipt withDelegate:(id<LLLikeReceiptHelperDelegate>)delegate {
    self.receipt = receipt;
    self.delegate = delegate;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Description:" message:@"Enter description for the command" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    // Use tag to remember index of the receipt for now. Later if we show more alert views, may consider to use a property.
    [alertView show];
}

#pragma mark - Alert View delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Done"]) {
        UITextField *descTextField = [alertView textFieldAtIndex:0];
        NSString *desc = descTextField.text;
        
        BOOL changed = [LLCommandManager assignDefaultGroupForReceipt:self.receipt withDescription:desc];
        if (changed) {
            [self.delegate onFinishedLiking:self.receipt];
        } else {
            [self.delegate onFailedLiking:self.receipt];
        }
    }
}

@end

//
//  LLPrefillOptionValuePrototypeCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 12/3/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionValuePrototypeCell.h"

#define NIB_PREFILL_OPTION_VALUE_PROTOTYPE_CELL @"LLPrefillOptionValuePrototypeCell"
#define IDENTIFIER_PREFILL_OPTION_VALUE_PROTOTYPE_CELL @"PrefillOptionValuePrototypeCell"

@protocol LLPrefillOptionValuePrototypeCellDelegate

- (void)onTextFieldDidEndEditing:(id)cell;

@end

@interface LLPrefillOptionValuePrototypeCell : LLOptionValuePrototypeCell <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) id<LLPrefillOptionValuePrototypeCellDelegate> delegate;

@end

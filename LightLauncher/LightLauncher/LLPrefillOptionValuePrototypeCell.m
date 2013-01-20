//
//  LLPrefillOptionValuePrototypeCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/3/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLPrefillOptionValuePrototypeCell.h"
#import "LLOptionValuePrototype.h"

@implementation LLPrefillOptionValuePrototypeCell

- (void)updateViewWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype andValueType:(OptionValueType)valueType atIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;

    NSString *text = optionValuePrototype.value;
    UIKeyboardType keyboardType = UIKeyboardAppearanceDefault;
    if (valueType == TYPE_EMAIL) {
        keyboardType = UIKeyboardTypeEmailAddress;
    } else if (valueType == TYPE_URL) {
        keyboardType = UIKeyboardTypeURL;
        if (!text) {
            text = @"http://";
        }
    }
    
    if (text) {
        self.textField.text = text;
    } else {
        self.textField.placeholder = optionValuePrototype.displayName;
    }
    
    self.textField.keyboardType = keyboardType;
    
    BOOL selected = optionValuePrototype.selected;
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate onTextFieldDidEndEditing:self];
}

- (void)dealloc {
    self.textField.delegate = nil;
    self.textField = nil;
    self.delegate = nil;
}

@end

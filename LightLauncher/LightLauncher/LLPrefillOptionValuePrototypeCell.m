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

- (void)updateViewWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype atIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    self.textField.text = optionValuePrototype.value;
    self.textField.placeholder = optionValuePrototype.displayName;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    
    if (optionValuePrototype.type == TYPE_EMAIL) {
        self.textField.keyboardType = UIKeyboardTypeEmailAddress;
    } else if (optionValuePrototype.type == TYPE_URL) {
        self.textField.keyboardType = UIKeyboardTypeURL;
    } else {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
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

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

- (void)updateView {
    self.textField.placeholder = self.optionValuePrototype.displayName;
    
    if (self.optionValuePrototype.type == TYPE_EMAIL) {
        self.textField.keyboardType = UIKeyboardTypeEmailAddress;
    } else if (self.optionValuePrototype.type == TYPE_URL) {
        self.textField.keyboardType = UIKeyboardTypeURL;
    } else {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    self.accessoryType = self.optionValuePrototype.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end

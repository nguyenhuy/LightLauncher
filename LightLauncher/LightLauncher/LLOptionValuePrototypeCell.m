//
//  LLOptionValueCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/7/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionValuePrototypeCell.h"
#import "LLOptionValuePrototype.h"

@implementation LLOptionValuePrototypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 100);
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return self;
}

- (void)setOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype {
    if (_optionValuePrototype) {
        _optionValuePrototype = nil;
    }
    
    _optionValuePrototype = optionValuePrototype;
    
    if (_optionValuePrototype) {
        if (_optionValuePrototype.value == nil) {
            self.textLabel.text = _optionValuePrototype.displayName;
        } else {
            self.textLabel.text = [_optionValuePrototype valueString];
        }
        self.accessoryType = _optionValuePrototype.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

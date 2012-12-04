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
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return self;
}

- (void)updateViewWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype atIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.textLabel.text = optionValuePrototype.displayName;
    self.accessoryType = optionValuePrototype.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

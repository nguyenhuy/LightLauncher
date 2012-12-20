//
//  LLOptionValueCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 11/7/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOptionValuePrototypeCell.h"
#import "LLOptionValuePrototype.h"

@interface LLOptionValuePrototypeCell ()
- (void)setup;
@end

@implementation LLOptionValuePrototypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)updateViewWithOptionValuePrototype:(LLOptionValuePrototype *)optionValuePrototype atIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.textLabel.text = optionValuePrototype.displayName;
    self.accessoryType = optionValuePrototype.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end

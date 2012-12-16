//
//  LLCommandCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandPrototypeCell.h"
#import "LLCommandPrototype.h"
#import "LLCommand.h"

@implementation LLCommandPrototypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 100);
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return self;
}

- (void)setCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (_commandPrototype) {
        _commandPrototype = nil;
    }
    
    _commandPrototype = commandPrototype;
    
    if (_commandPrototype) {
        self.imageView.image = [UIImage imageNamed:commandPrototype.iconFileName];
        self.textLabel.text = commandPrototype.desc;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

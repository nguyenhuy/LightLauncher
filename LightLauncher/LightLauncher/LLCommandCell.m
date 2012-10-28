//
//  LLCommandCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandCell.h"
#import "LLCommand.h"

@implementation LLCommandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 100);
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return self;
}

- (void)setCommand:(LLCommand *)command {
    self.imageView.image = [UIImage imageNamed:[[command class] iconFileName]];
    self.textLabel.text = [[command class] description];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

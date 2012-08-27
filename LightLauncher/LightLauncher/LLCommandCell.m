//
//  LLCommandCell.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandCell.h"
#import "LLCommand.h"

#define COMMAND_CELL @"CommandCell"

@implementation LLCommandCell

+ (LLCommandCell *)instanceWithCommand:(LLCommand *)command {
    LLCommandCell *cell = [[LLCommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COMMAND_CELL];
    cell.frame = CGRectMake(0, 0, 320, 100);
    
    cell.imageView.image = [UIImage imageNamed:[command iconFileName]];
    cell.textLabel.text = [command description];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

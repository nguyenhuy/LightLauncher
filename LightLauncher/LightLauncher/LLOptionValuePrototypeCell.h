//
//  LLOptionValueCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/7/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDENTIFIER_OPTION_VALUE_PROTOTYPE_CELL @"OptionValuePrototypeCell"

@class LLOptionValuePrototype;

@interface LLOptionValuePrototypeCell : UITableViewCell

@property (strong, nonatomic) LLOptionValuePrototype* optionValuePrototype;

@end

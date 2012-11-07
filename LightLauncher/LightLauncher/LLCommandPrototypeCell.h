//
//  LLCommandCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDENTIFIER_COMMAND_PROTOTYPE_CELL @"CommandPrototypeCell"

@class LLCommandPrototype;

@interface LLCommandPrototypeCell : UITableViewCell

@property (nonatomic, strong) LLCommandPrototype *commandPrototype;

@end

//
//  LLCommandCell.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLCommand;

@interface LLCommandCell : UITableViewCell

+(LLCommandCell *)instanceWithCommand:(LLCommand *)command;

@end

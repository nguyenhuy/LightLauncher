//
//  LLCreateCommandViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

//@TODO maynot need those defines if we already have newInstance
#define NIB_COMMAND_PROTOTYPE_TABLE_VIEW_CONTROLLER @"LLCommandPrototypeTableViewController"

@interface LLCommandPrototypeTableViewController : UITableViewController

+ (LLCommandPrototypeTableViewController *)newInstance;

@end

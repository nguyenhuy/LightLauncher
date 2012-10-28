//
//  LLCreateCommandViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 10/29/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NIB_CREATE_COMMAND_VIEW_CONTROLLER @"LLCreateCommandViewController"

@class LLCommand;

@interface LLCreateCommandViewController : UITableViewController

@property (nonatomic, strong) LLCommand *command;

@end

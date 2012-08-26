//
//  LLViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLReceiptManager;

@interface LLViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LLReceiptManager* receiptManager;
@property (nonatomic, strong) IBOutlet UITextField *textFieldInput;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

//
//  LLViewController.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLReceiptManager;

@interface LLViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) LLReceiptManager* receiptManager;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCommand;
@property (strong, nonatomic) IBOutlet UIView *statusView;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftToRightSwipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightToLeftSwipeGestureRecognizer;

- (IBAction)onSwipeStatusViewLeftToRight:(id)sender;
- (IBAction)onSwipeStatusViewRightToLeft:(id)sender;


@end

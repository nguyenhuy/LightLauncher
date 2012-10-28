//
//  LLViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCreateCommandViewController.h"
#import "LLReceiptManager.h"
#import "LLCommandCell.h"
#import "LLCommand.h"

@interface LLCreateCommandViewController ()
- (void)configCommandTextField;
- (void)configSwipeGestureRecognizer;
- (void)registerForKeyboardNotifications;
- (void)keyboardWasShown:(NSNotification *)notification;
- (void)keyboardWillBeHidden:(NSNotification *)notification;
@end

@implementation LLCreateCommandViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.receiptManager = [[LLReceiptManager alloc] init];
    [self configCommandTextField];
    [self configSwipeGestureRecognizer];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setHeaderView:nil];
    [self setTextFieldCommand:nil];
    [self setStatusView:nil];
    [self setLblStatus:nil];
    [self setLeftToRightSwipeGestureRecognizer:nil];
    [self setRightToLeftSwipeGestureRecognizer:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITableViewCellDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LLCommandCell instanceWithCommand:[self.receiptManager.commands objectAtIndex:indexPath.row]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.receiptManager.commands count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LLCommand *command = [self.receiptManager.commands objectAtIndex:indexPath.row];
    [self.receiptManager executeFromCommand:command withViewController:self];
}

#pragma mark - Command Text Field and UITextFieldDelegate
- (void)configCommandTextField {
    self.textFieldCommand.delegate = self;
    
    [self registerForKeyboardNotifications];
    // Show the keyboard immediately
    [self.textFieldCommand resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.receiptManager executeFromString:self.textFieldCommand.text withViewController:self];
    return YES;
}

#pragma mark - Keyboard Notifications

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Swipe Gesture Recognizers

- (void)configSwipeGestureRecognizer {
    self.leftToRightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    self.rightToLeftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
}

- (IBAction)onSwipeStatusViewLeftToRight:(id)sender {
    DLog(@"Left to Right");
}

- (IBAction)onSwipeStatusViewRightToLeft:(id)sender {
    DLog(@"Right to Left");    
}

@end

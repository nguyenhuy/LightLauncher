//
//  LLCreateCommandViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/29/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCreateCommandTableViewController.h"

#import "LLCommand.h"
#import "LLCommandManager.h"

#import "LLCommandPrototype.h"
#import "LLOptionPrototype.h"
#import "LLOptionValuePrototype.h"

#import "LLOptionValuePrototypeCell.h"
#import "UIViewController+ShowHUD.h"

@interface LLCreateCommandTableViewController ()
- (void)setupToolbar;
- (LLOptionPrototype *)optionPrototypeAtIndexPath:(NSIndexPath *)indexPath;
- (LLOptionPrototype *)optionPrototypeAtIndex:(int)index;
- (LLOptionValuePrototype *)optionValuePrototypeAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateTableViewAndReloadOptionValueAtIndexPath:(NSIndexPath *)indexPath withValue:(id)value;
@end

@implementation LLCreateCommandTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.commandPrototype.desc;
    [self setupToolbar];
    
    [self.tableView registerClass:[LLOptionValuePrototypeCell class] forCellReuseIdentifier:IDENTIFIER_OPTION_VALUE_PROTOTYPE_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:NIB_PREFILL_OPTION_VALUE_PROTOTYPE_CELL bundle:nil] forCellReuseIdentifier:IDENTIFIER_PREFILL_OPTION_VALUE_PROTOTYPE_CELL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)dealloc {
    self.likeReceiptHelper = nil;
    self.commandPrototype = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.commandPrototype.options count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LLOptionPrototype *optionPrototype = [self.commandPrototype.options objectAtIndex:section];
    return [optionPrototype.possibleValues count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.commandPrototype.options objectAtIndex:section] displayName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLOptionPrototype *option = [self optionPrototypeAtIndexPath:indexPath];
    LLOptionValuePrototype *optionValuePrototype = [self optionValuePrototypeAtIndexPath:indexPath];
    
    // Right now LLPrefillOptionValuePrototypeCell only supports string option value types
    if ([optionValuePrototype.key isEqualToString:OPTION_VALUE_PREFILL] && [LLUtils isStringOptionValueType:option.valueType]) {
        LLOptionPrototype *optionPrototype = [self optionPrototypeAtIndexPath:indexPath];
        
        LLPrefillOptionValuePrototypeCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_PREFILL_OPTION_VALUE_PROTOTYPE_CELL forIndexPath:indexPath];
        ((LLPrefillOptionValuePrototypeCell *) cell).delegate = self;
        [cell updateViewWithOptionValuePrototype:optionValuePrototype andValueType:optionPrototype.valueType atIndexPath:indexPath];
        return cell;
    } else {
        LLOptionValuePrototypeCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_OPTION_VALUE_PROTOTYPE_CELL forIndexPath:indexPath];
        [cell updateViewWithOptionValuePrototype:optionValuePrototype atIndexPath:indexPath];
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LLOptionPrototype *option = [self optionPrototypeAtIndexPath:indexPath];
    LLOptionValuePrototype *optionValuePrototype = [self optionValuePrototypeAtIndexPath:indexPath];
    
    if ([optionValuePrototype.key isEqualToString:OPTION_VALUE_PREFILL] && [LLUtils isStringOptionValueType:option.valueType]) {
        // Don't select prefill cells, since the UITextField is on top
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateTableViewAndReloadOptionValueAtIndexPath:indexPath withValue:nil];
}

#pragma mark - Prefill option value prototype cell delegate

- (void)onTextFieldDidEndEditing:(id)cell {
    LLPrefillOptionValuePrototypeCell *prefillCell = cell;
    NSIndexPath *indexPath = prefillCell.indexPath;
    NSString *value = prefillCell.textField.text;
    
    // Only update the option value prototype if text was set
    if ([value length] != 0) {
        [self updateTableViewAndReloadOptionValueAtIndexPath:indexPath withValue:value];
    }
}

#pragma mark - Like receipt helper delegate

- (void)onFinishedLiking {
    self.likeReceiptHelper = nil;
    [self showCheckmarkHUDWithLabelText:@"Added"];
}

- (void)onFailedLiking {
    self.likeReceiptHelper = nil;
    [self showTextHUDWithLabelText:@"Error. Try later"];
}

#pragma mark - Command Delegate

- (void)onFinishedCommand:(LLCommand *)command {
    [self showExecutedCommandHUD];
}

- (void)onStoppedCommand:(LLCommand *)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self showErrorHUDWithTitle:title andDesc:desc];
}

#pragma mark - Instance methods

- (void)setupToolbar {
    UIBarButtonItem *flexibleSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *executeBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(executeCommand)];
    UIBarButtonItem *likeBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(likeCommand)];

    [self.navigationController setToolbarHidden:NO animated:YES];
    self.toolbarItems = [NSArray arrayWithObjects:flexibleSpaceBarButtonItem, likeBarButtonItem, flexibleSpaceBarButtonItem, executeBarButtonItem, flexibleSpaceBarButtonItem, nil];
}

- (void)executeCommand {
    [[LLCommandManager sharedInstance] executeFromCommandPrototype:self.commandPrototype withViewController:self andDelegate:self];
}

- (void)likeCommand {
    self.likeReceiptHelper = [[LLLikeCommandHelper alloc] init];
    [self.likeReceiptHelper likeCommandPrototype:self.commandPrototype withDelegate:self];
}

- (LLOptionPrototype *)optionPrototypeAtIndexPath:(NSIndexPath *)indexPath {
    return [self optionPrototypeAtIndex:indexPath.section];
}

- (LLOptionPrototype *)optionPrototypeAtIndex:(int)index {
    return [self.commandPrototype.options objectAtIndex:index];
}

- (LLOptionValuePrototype *)optionValuePrototypeAtIndexPath:(NSIndexPath *)indexPath {
    LLOptionPrototype *optionPrototype = [self optionPrototypeAtIndexPath:indexPath];
    LLOptionValuePrototype *optionValuePrototype = [[optionPrototype.possibleValues allValues] objectAtIndex:indexPath.row];
    return optionValuePrototype;
}

// @TODO is it a good name?
- (void)updateTableViewAndReloadOptionValueAtIndexPath:(NSIndexPath *)indexPath withValue:(id)value {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LLOptionPrototype *option = [self optionPrototypeAtIndexPath:indexPath];
    LLOptionValuePrototype *optionValue = [self optionValuePrototypeAtIndexPath:indexPath];

    // Deselect all other option values if this option value will be selected and not an array option
    if (!optionValue.selected && option.dataType != DATA_ARRAY) {
        for (LLOptionValuePrototype *optionValue in option.possibleValues.allValues) {
            optionValue.selected = NO;
        }
    }
    
    // Toggle selected value
    optionValue.selected = !optionValue.selected;
    optionValue.value = value;
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

@end

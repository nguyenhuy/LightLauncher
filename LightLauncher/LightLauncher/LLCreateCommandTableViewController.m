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



@interface LLCreateCommandTableViewController ()
@property (nonatomic, strong, readwrite) LLCommand *command;
@end

@implementation LLCreateCommandTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setCommandPrototype:(LLCommandPrototype *)commandPrototype {
    if (_commandPrototype) {
        _commandPrototype = nil;
        _command = nil;
    }
    
    _commandPrototype = commandPrototype;
    
    if (commandPrototype) {
        _command = [_commandPrototype.command copy];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [[self.commandPrototype.command class] description];
    
    [self.tableView registerClass:[LLOptionValuePrototypeCell class] forCellReuseIdentifier:IDENTIFIER_OPTION_VALUE_PROTOTYPE_CELL];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *executeBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(executeCommand)];
    self.navigationItem.rightBarButtonItem = executeBarButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    LLOptionValuePrototypeCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_OPTION_VALUE_PROTOTYPE_CELL];
    
    LLOptionPrototype *optionPrototype = [self.commandPrototype.options objectAtIndex:indexPath.section];
    NSObject *value = [self.command valueForKey:optionPrototype.key];
    
    LLOptionValuePrototype *optionValuePrototype = [[optionPrototype.possibleValues allValues] objectAtIndex:indexPath.row];
    cell.optionValuePrototype = optionValuePrototype;
    
    if (value && optionValuePrototype.key == OPTION_VALUE_PREFILL) {
        if ([value isKindOfClass:[NSString class]]) {
            cell.textLabel.text = (NSString *) value;
        } else if([value isKindOfClass:[NSArray class]]) {
            // Must be prefill
            cell.textLabel.text = [((NSArray *) value) componentsJoinedByString:@", "];
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Instance methods

- (void)executeCommand {
    [[LLCommandManager sharedInstance] executeFromCommand:self.command withCommandPrototype:self.commandPrototype withViewController:self];
}

@end

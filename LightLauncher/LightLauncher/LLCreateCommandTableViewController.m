//
//  LLCreateCommandViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/29/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCreateCommandTableViewController.h"
#import "LLCommandPrototype.h"
#import "LLOptionPrototype.h"
#import "LLCommand.h"
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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSObject *optionValue = [self.command valueForKey:optionPrototype.key];
    
    if (optionValue) {
        NSString *title = nil;
        if ([optionValue isKindOfClass:[NSString class]]) {
            title = (NSString *) optionValue;
        } else if([optionValue isKindOfClass:[NSArray class]]) {
            title = [((NSArray *) optionValue) componentsJoinedByString:@", "];
        }
        cell.textLabel.text = title;
    } else {
        LLOptionValuePrototype *optionValuePrototype = [[optionPrototype.possibleValues allValues] objectAtIndex:indexPath.row];
        cell.optionValuePrototype = optionValuePrototype;
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

@end

//
//  LLHistoryTableViewController.m
//  LightLauncher
//
//  Created by Huy Nguyen on 12/17/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLHistoryTableViewController.h"
#import "LLCreateCommandTableViewController.h"
#import "LLInfoPanelView.h"

#import "LLCommandManager.h"
#import "LLCommandParser.h"

#import "LLCommandPrototype.h"

#import "Receipt.h"

#import "UIViewController+ShowHUD.h"
#import "UIViewController+SetupSideMenu.h"

@interface LLHistoryTableViewController ()
- (void)showRightEditBarButtonItem;
- (void)showRightDoneBarButtonItem;
- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark - KNPathTableViewController
- (void)setupInfoPanel;
- (void)moveInfoPanelToSuperView;
- (void)moveInfoPanelToIndicatorView;
- (void)slideOutInfoPanel;
@end

@implementation LLHistoryTableViewController

+ (LLHistoryTableViewController *)newInstance {
    return [[LLHistoryTableViewController alloc] initWithNibName:@"LLHistoryTableViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"History";
    [self.tableView registerClass:[LLHistoryCell class] forCellReuseIdentifier:IDENTIFIER_HISTORY_CELL];
    [self setupSideMenu];
    [self showRightEditBarButtonItem];
    [self setupInfoPanel];
}

- (void)viewWillAppear:(BOOL)animated {
    self.receipts = [LLCommandManager loadReceiptsFromDB];
    [self.tableView reloadData];
}

- (void)dealloc {
    self.likeReceiptHelper = nil;
    self.receipts = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.receipts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
    LLHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_HISTORY_CELL forIndexPath:indexPath];
    [cell updateViewWithReceipt:receipt atIndexPath:indexPath andDelegate:self];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
    LLCommandManager *commandManager = [LLCommandManager sharedInstance];
    [commandManager executeFromCommandPrototype:receipt.commandPrototype withViewController:self andDelegate:self];
    
    // Load again from DB
    //@TODO may use model observer for CommandManager
    self.receipts = [LLCommandManager loadReceiptsFromDB];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteReceiptAtIndexPath:indexPath];
    }
}

#pragma mark - History cell delegate

- (void)onToggleGroupOfReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    if ([receipt liked]) {
        // Unlike
        BOOL changed = [LLCommandManager removeGroupForReceipt:receipt];
        if (changed) {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
        }
    } else {
        // Like
        self.likeReceiptHelper = [[LLLikeReceiptHelper alloc] init];
        [self.likeReceiptHelper likeReceipt:receipt withDelegate:self];
    }
}

- (void)onDuplicateReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    
    LLCreateCommandTableViewController *controller = [[LLCreateCommandTableViewController alloc] initWithNibName:NIB_CREATE_COMMAND_VIEW_CONTROLLER bundle:nil];
    controller.commandPrototype = receipt.commandPrototype;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Like receipt helper delegate

- (void)onFinishedLiking:(Receipt *)receipt {
    self.likeReceiptHelper = nil;
    int index = [self.receipts indexOfObject:receipt];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
}

- (void)onFailedLiking:(Receipt *)receipt {
    self.likeReceiptHelper = nil;
    [self showErrorHUDWithTitle:@"Failed" andDesc:nil];
}

#pragma mark - Command delegate

- (void)onFinishedCommand:(id)command {
    [self showExecutedCommandHUD];
    
    self.receipts = [LLCommandManager loadReceiptsFromDB];
    [self.tableView reloadData];
}

- (void)onStoppedCommand:(id)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc {
    [self showErrorHUDWithTitle:title andDesc:desc];
}

#pragma mark - Instance methods

- (void)showRightEditBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
}

- (void)showRightDoneBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditting)];
}

- (void)deleteReceiptAtIndexPath:(NSIndexPath *)indexPath {
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    BOOL deleted = [LLCommandManager deleteReceipt:receipt];
    if (deleted) {
        // Load again from DB
        self.receipts = [LLCommandManager loadReceiptsFromDB];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Done editing if there is no more receipt
        if (!self.receipts || self.receipts.count == 0) {
            [self doneEditting];
        }
    } else {
        //@TODO log to Crittercism
        //@TODO may handle error here
    }
}

- (void)edit {
    [self.tableView setEditing:YES animated:YES];
    [self showRightDoneBarButtonItem];
}

- (void)doneEditting {
    [self.tableView setEditing:NO animated:YES];
    [self showRightEditBarButtonItem];
}

#pragma mark - KNPathTableViewController

- (void)setupInfoPanel {
    self.infoPanel = [LLInfoPanelView newInstance];
    [self.infoPanel setAlpha:0];
    
    UIImage * overlay = [UIImage imageNamed:IMAGE_PATH_OVERLAY];
    self.infoPanel.backgroundImage.image = [overlay stretchableImageWithLeftCapWidth:overlay.size.width/2.0 topCapHeight:overlay.size.height/2.0];
}

#pragma mark - Meant to be override

-(void)infoPanelWillAppear:(UIScrollView*)scrollView {}
-(void)infoPanelDidAppear:(UIScrollView*)scrollView {}
-(void)infoPanelWillDisappear:(UIScrollView*)scrollView {}
-(void)infoPanelDidDisappear:(UIScrollView*)scrollView {}
-(void)infoPanelDidStopScrolling:(UIScrollView*)scrollView {}

-(void)infoPanelDidScroll:(UIScrollView*)scrollView atPoint:(CGPoint)point {
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
    [self.infoPanel updateViewWithDate:receipt.executedDate];
}

#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // Store height of indicator
    UIView * indicator = [[self.tableView subviews] lastObject];
    self.infoPanel.initalScrollIndicatorHeight = indicator.frame.size.height;
    
    // Starting from beginning
    if ([self.infoPanel superview] == nil) {
        // Add it to indicator
        [self moveInfoPanelToIndicatorView];
        
		// Prepare to slide in
        CGRect f = self.infoPanel.frame;
        CGRect f2= f;
        f2.origin.x += KNPathTableSlideInOffset;
		[self.infoPanel setFrame:f2];
        
        // Fade in and slide left
        [self infoPanelWillAppear:scrollView];
        [UIView animateWithDuration:KNPathTableFadeInDuration
                         animations:^{
                             self.infoPanel.alpha = 1;
                             self.infoPanel.frame = f;
                         } completion:^(BOOL finished) {
                             [self infoPanelDidAppear:scrollView];
                         }];
	}
    
    // If it is waiting to fade out, then maintain position
    else if ([self.infoPanel superview] == self.view) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(slideOutInfoPanel) object:nil];
        [self moveInfoPanelToIndicatorView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView * indicator = [[scrollView subviews] lastObject];
    
    // Make sure the panel is visible
    if (self.infoPanel.alpha == 0) self.infoPanel.alpha = 1;
    
	// Current position is near bottom
	if (indicator.frame.size.height < self.infoPanel.initalScrollIndicatorHeight) {
        if (scrollView.contentOffset.y > 0 && [self.infoPanel superview] != self.view) {
            // Move panel to a fixed position
            [self.infoPanel removeFromSuperview];
            CGRect f = [self.view convertRect:self.infoPanel.frame fromView:indicator];
            self.infoPanel.frame = CGRectMake(f.origin.x, self.tableView.frame.size.height-f.size.height, f.size.width, f.size.height);
            [self.view addSubview:self.infoPanel];
        }
	}
    
    // Return the panel to indicator
    else if ([self.infoPanel superview] != indicator) {
        [self moveInfoPanelToIndicatorView];
    }
    
    // The current center of panel
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [self infoPanelDidScroll:scrollView atPoint:CGPointMake(indicator.center.x,scrollView.contentSize.height-1)];
    } else {
        [self infoPanelDidScroll:scrollView atPoint:indicator.center];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // Remove it from indicator view but maintain position
    if ([self.infoPanel superview] != self.view) [self moveInfoPanelToSuperView];
    [self performSelector:@selector(slideOutInfoPanel) withObject:nil afterDelay:KNPathTableFadeOutDelay];
    [self infoPanelDidStopScrolling:scrollView];
}

#pragma mark - Helper methods

-(void)moveInfoPanelToSuperView {
    UIView * indicator = [[self.tableView subviews] lastObject];
    CGRect f = [self.view convertRect:self.infoPanel.frame fromView:indicator];
    if ([self.infoPanel superview]) [self.infoPanel removeFromSuperview];
    self.infoPanel.frame = f;
    [self.view addSubview:self.infoPanel];
}

-(void)moveInfoPanelToIndicatorView {
    UIView * indicator = [[self.tableView subviews] lastObject];
    CGRect f = self.infoPanel.initialFrame;
    f.origin.y = indicator.frame.size.height/2 - f.size.height/2;
    if ([self.infoPanel superview]) [self.infoPanel removeFromSuperview];
    [indicator addSubview:self.infoPanel];
    self.infoPanel.frame = f;
    
    self.tableView.in
}

-(void)slideOutInfoPanel {
    CGRect f = self.infoPanel.frame;
    f.origin.x += KNPathTableSlideInOffset;
    [self infoPanelWillDisappear:self.tableView];
    [UIView animateWithDuration:KNPathTableFadeOutDuration
                     animations:^{
                         self.infoPanel.alpha = 0;
                         self.infoPanel.frame = f;
                     } completion:^(BOOL finished) {
                         [self.infoPanel removeFromSuperview];
                         [self infoPanelDidDisappear:self.tableView];
                     }];
}

@end

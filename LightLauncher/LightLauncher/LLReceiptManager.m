//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLReceiptManager.h"
#import "LLTwitterCommand.h"
#import "LLEmailCommand.h"

@interface LLReceiptManager ()
@property (nonatomic, strong, readwrite) NSMutableArray* receipts;
@property (nonatomic, strong, readwrite) NSMutableArray* commands;
@end

@implementation LLReceiptManager

@synthesize receipts = _receipts;
@synthesize commands = _commands;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.commands = [NSMutableArray arrayWithObjects:
                         [[LLTwitterCommand alloc] initWithCommand:@"tw" AndOptions:nil],
                         [[LLEmailCommand alloc] initWithCommand:@"em" AndOptions:nil],
                         nil];
    }
    return self;
}

@end

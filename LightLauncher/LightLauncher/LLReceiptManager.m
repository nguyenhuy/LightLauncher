//
//  LLReceiptManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLReceiptManager.h"

@interface LLReceiptManager ()
@property (strong, nonatomic, readwrite) NSMutableArray* receipts;
@end

@implementation LLReceiptManager

@synthesize receipts = _receipts;

@end

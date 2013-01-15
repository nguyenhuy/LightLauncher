//
//  LLGooglePlusCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/15/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLCommand.h"
#import "GPPShare.h"

@interface LLGooglePlusCommand : LLCommand <GPPShareDelegate>

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSURL *url;

@end

//
//  LLOpenInChromeCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/21/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLUrlSchemeCommand.h"

@interface LLOpenInChromeUrlSchemeCommand : LLUrlSchemeCommand

@property (nonatomic, strong) NSURL *url;
@property (nonatomic) BOOL createNewTab;

@end

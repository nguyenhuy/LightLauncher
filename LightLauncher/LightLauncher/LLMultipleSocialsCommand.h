//
//  LLMultipleSocialCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/13/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"
#import "REComposeViewController.h"

@interface LLMultipleSocialsCommand : LLSocialCommand <LLCommandDelegate, REComposeViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *serviceTypes;
@property (nonatomic) int executedServicesCounter;

@end

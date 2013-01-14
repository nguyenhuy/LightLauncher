//
//  LLMultipleSocialCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/13/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLSocialCommand.h"

@interface LLMultipleSocialsCommand : LLCommand <LLCommandDelegate>

// Array of NSStrings
@property (nonatomic, strong) NSMutableArray *serviceTypes;
@property (nonatomic, strong) NSString *body;
// Array of NSURLs
@property (nonatomic, strong) NSMutableArray *urls;
// Array of UIImages
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic) int executedServicesCounter;

@end

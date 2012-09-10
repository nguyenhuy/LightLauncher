//
//  LLImageOption.h
//  LightLauncher
//
//  Created by Huy Nguyen on 9/11/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOption.h"

@interface LLImageOption : LLOption

@property (nonatomic, strong) UIImage* image;

-(id)initWithWithImage:(UIImage *)image;

@end

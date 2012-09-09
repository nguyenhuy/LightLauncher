//
//  LLBodyOption.h
//  LightLauncher
//
//  Created by Huy Nguyen on 9/9/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOption.h"

@interface LLBodyOption : LLOption

@property (nonatomic) BOOL isHtml;

- (id)initWithParam:(NSString *)param AndIsHtml:(BOOL)isHtml;

@end

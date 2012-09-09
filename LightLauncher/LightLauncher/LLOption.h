//
//  LLOption.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLOption : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* param;

- (id)initWithParam:(NSString *)param;

@end

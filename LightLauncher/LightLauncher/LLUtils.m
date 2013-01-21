//
//  LLUtils.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/21/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLUtils.h"

@implementation LLUtils

+ (BOOL)isStringOptionValueType:(OptionValueType)valueType {
    return valueType == TYPE_STRING || valueType == TYPE_EMAIL || valueType == TYPE_URL;
}

@end

//
//  NSObject+IsEmpty.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "NSObject+IsEmpty.h"

@implementation NSObject (IsEmpty)

- (BOOL)isEmpty {
    return self == nil
    || (self == [NSNull null])
    || ([self respondsToSelector:@selector(length)]
        && [(NSData *)self length] == 0)
    || ([self respondsToSelector:@selector(count)]
        && [(NSArray *)self count] == 0);
}

@end

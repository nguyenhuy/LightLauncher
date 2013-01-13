//
//  LLSavingTimeManager.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/6/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLSavingTimeManager.h"
#import "LLCommand.h"

#define KEY_SAVING_TIME @"savingTime"

@implementation LLSavingTimeManager

+ (void)addObserver:(NSObject *)observer {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults addObserver:observer forKeyPath:KEY_SAVING_TIME options:0 context:nil];
}

+ (void)removeObserver:(NSObject *)observer {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObserver:observer forKeyPath:KEY_SAVING_TIME context:nil];
}

+ (void)increaseSavingTimeWithCommand:(LLCommand *)command {
    NSUInteger totalSavingTime = [LLSavingTimeManager totalSavingTime];
    NSUInteger savingTime = [LLSavingTimeManager savingTimeForCommand:command];
    NSUInteger newTotalSavingTime = totalSavingTime + savingTime;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:newTotalSavingTime forKey:KEY_SAVING_TIME];
    [userDefaults synchronize];
}

+ (NSUInteger)savingTimeForCommand:(LLCommand *)command {
    // Let's make it simple, each option value worths 5 seconds
    //@TODO fix this #6
    return 15;
}

+ (NSUInteger)totalSavingTime {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:KEY_SAVING_TIME];
}

@end

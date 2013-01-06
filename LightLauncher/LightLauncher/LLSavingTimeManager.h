//
//  LLSavingTimeManager.h
//  LightLauncher
//
//  Created by Huy Nguyen on 1/6/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLCommand;

@interface LLSavingTimeManager : NSObject

// The object to register for Saving time notifications.
// The observer must implement the key-value observing method observeValueForKeyPath:ofObject:change:context:.
+ (void)addObserver:(NSObject *)observer;
+ (void)removeObserver:(NSObject *)observer;

+ (void)increaseSavingTimeWithCommand:(LLCommand *)command;
+ (NSUInteger)savingTimeForCommand:(LLCommand *)command;
+ (NSUInteger)totalSavingTime;

@end

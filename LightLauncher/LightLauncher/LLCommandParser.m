//
//  LLCommandParser.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandParser.h"
#import "NSObject+IsEmpty.h"
#import "JSONKit.h"
#import "LLCommandPrototype.h"
#import "LLCommand.h"
#import "LLEmailCommand.h"
#import "LLFacebookCommand.h"
#import "LLTwitterCommand.h"

@interface LLCommandParser ()
+ (Class)commandClassFromString:(NSString *)commandString;
@end

@implementation LLCommandParser

+ (NSString *)encode:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return nil;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dict setObject:commandPrototype.command forKey:JSON_KEY_COMMAND];
    [dict setObject:commandPrototype.options forKey:JSON_KEY_OPTIONS];
    
    NSString *jsonString = [dict JSONString];
    return jsonString;
}

+ (LLCommandPrototype *)decode:(NSString *)json {
    if ([json isEmpty]) {
        return nil;
    }
    
    NSMutableDictionary *dict = [json mutableObjectFromJSONString];
    
    NSString *commandString = [dict objectForKey:JSON_KEY_COMMAND];
    if ([commandString isEmpty]) {
        return nil;
    }

    Class commandClass = [self commandClassFromString:commandString];
    if (commandClass == nil || ![commandClass isSubclassOfClass:[LLCommand class]]) {
        return nil;
    }

    LLCommand *command = [[commandClass alloc] init];
    command.options = [dict objectForKey:JSON_KEY_OPTIONS];
    return command;
}

@end

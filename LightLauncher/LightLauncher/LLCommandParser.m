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
#import "LLOptionPrototype.h"
#import "LLOptionValuePrototype.h"
#import "LLCommand.h"
#import "LLEmailCommand.h"
#import "LLFacebookCommand.h"
#import "LLTwitterCommand.h"

#define JSON_COMMAND @"command"
#define JSON_OPTIONS @"options"

#define JSON_KEY @"key"
#define JSON_PISSIBLE_VALUES @"possible_values"

#define JSON_SELECTED @"selected"
#define JSON_VALUE @"value"

@interface LLCommandParser ()
+ (NSArray *)jsonArrayFromOptionPrototypes:(NSArray *)optionPrototypes;
+ (NSArray *)jsonArrayFromOptionValuePrototypes:(NSArray *)optionValuePrototypes;
@end

@implementation LLCommandParser

+ (NSString *)encode:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return nil;
    }
    
    // Desc and iconFileName of commandPrototype is not encoded because it can be got back (and updated) at run time.
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dict setObject:commandPrototype.command forKey:JSON_COMMAND];
    [dict setObject:[self jsonArrayFromOptionPrototypes:commandPrototype.options] forKey:JSON_OPTIONS];
    
    NSString *jsonString = [dict JSONString];
    return jsonString;
}

+ (LLCommandPrototype *)decode:(NSString *)json {
//    if ([json isEmpty]) {
//        return nil;
//    }
//    
//    NSMutableDictionary *dict = [json mutableObjectFromJSONString];
//    
//    NSString *commandString = [dict objectForKey:JSON_KEY_COMMAND];
//    if ([commandString isEmpty]) {
//        return nil;
//    }
//
//    Class commandClass = [self commandClassFromString:commandString];
//    if (commandClass == nil || ![commandClass isSubclassOfClass:[LLCommand class]]) {
//        return nil;
//    }
//
//    LLCommand *command = [[commandClass alloc] init];
//    command.options = [dict objectForKey:JSON_KEY_OPTIONS];
//    return command;
}

+ (NSArray *)jsonArrayFromOptionPrototypes:(NSArray *)optionPrototypes {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:optionPrototypes.count];
    NSMutableDictionary *temp;
    
    for (LLOptionPrototype *o in optionPrototypes) {
        temp = [[NSMutableDictionary alloc] initWithCapacity:2];
        // dataType and displayName is not encoded because they can be got back (and updated) at run time
        [temp setObject:o.key forKey:JSON_KEY];
        [temp setObject:[self jsonArrayFromOptionValuePrototypes:o.possibleValues.allValues] forKey:JSON_PISSIBLE_VALUES];
        [result addObject:temp];
    }
    
    return result;
}

+ (NSArray *)jsonArrayFromOptionValuePrototypes:(NSArray *)optionValuePrototypes {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:optionValuePrototypes.count];
    NSMutableDictionary *temp;
    
    for (LLOptionValuePrototype *o in optionValuePrototypes) {
        temp = [[NSMutableDictionary alloc] initWithCapacity:3];
        // displayName and type is not encoded, because they can be got back (and updated) at run time
        [temp setObject:o.key forKey:JSON_KEY];
        [temp setObject:[NSNumber numberWithBool:o.selected] forKey:JSON_SELECTED];
        if (o.value) {
            [temp setObject:o.value forKey:JSON_VALUE];
        }
        [result addObject:temp];
    }

    return result;
}

@end

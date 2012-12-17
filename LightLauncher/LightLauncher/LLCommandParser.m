//
//  LLCommandParser.m
//  LightLauncher
//
//  Created by Huy Nguyen on 10/28/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLCommandParser.h"
#import "JSONKit.h"
#import "NSObject+IsEmpty.h"

#import "LLCommandPrototypeFactory.h"
#import "LLOptionPrototypeFactory.h"

#import "LLCommandPrototype.h"
#import "LLOptionPrototype.h"
#import "LLOptionValuePrototype.h"
#import "LLCommand.h"

#define JSON_COMMAND @"command"
#define JSON_OPTIONS @"options"

#define JSON_KEY @"key"
#define JSON_POSSIBLE_VALUES @"possible_values"

#define JSON_SELECTED @"selected"
#define JSON_VALUE @"value"

@interface LLCommandParser ()
+ (NSArray *)encodeOptionPrototypes:(NSArray *)optionPrototypes;
+ (NSArray *)encodeOptionValuePrototypes:(NSArray *)optionValuePrototypes;
+ (NSDictionary *)optionPrototypeDictFromJsonArray:(NSArray *)jsonArray;
@end

@implementation LLCommandParser

+ (NSString *)encode:(LLCommandPrototype *)commandPrototype {
    if (!commandPrototype) {
        return nil;
    }
    
    // Desc and iconFileName of commandPrototype is not encoded because it can be got back (and updated) at run time.
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dict setObject:commandPrototype.command forKey:JSON_COMMAND];
    [dict setObject:[self encodeOptionPrototypes:commandPrototype.options] forKey:JSON_OPTIONS];
    
    NSString *jsonString = [dict JSONString];
    return jsonString;
}

+ (LLCommandPrototype *)decode:(NSString *)json {
    if ([json isEmpty]) {
        return nil;
    }

    NSDictionary *commandPrototypeJsonDict = [json objectFromJSONString];
    
    NSString *command = [commandPrototypeJsonDict objectForKey:JSON_COMMAND];
    NSDictionary *optionJsonDict = [self optionPrototypeDictFromJsonArray:[commandPrototypeJsonDict objectForKey:JSON_OPTIONS]];

    LLCommandPrototype *commandPrototype = [LLCommandPrototypeFactory commandPrototypeForCommand:command];

    // Set value of OptionValuePrototyes to each OptionPrototype
    NSArray *possibleValueJsonArray;
    LLOptionValuePrototype *optionValuePrototype;
    for (LLOptionPrototype *o in commandPrototype.options) {
        possibleValueJsonArray = [optionJsonDict objectForKey:o.key];
        for (NSDictionary *v in possibleValueJsonArray) {
            optionValuePrototype = [o.possibleValues objectForKey:[v objectForKey:JSON_KEY]];
            optionValuePrototype.selected = [[v objectForKey:JSON_SELECTED] boolValue];
            optionValuePrototype.value = [v objectForKey:JSON_VALUE];
        }
    }
    
    return commandPrototype;
}

+ (NSArray *)encodeOptionPrototypes:(NSArray *)optionPrototypes {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:optionPrototypes.count];
    NSMutableDictionary *temp;
    
    for (LLOptionPrototype *o in optionPrototypes) {
        temp = [[NSMutableDictionary alloc] initWithCapacity:2];
        // dataType and displayName is not encoded because they can be got back (and updated) at run time
        [temp setObject:o.key forKey:JSON_KEY];
        [temp setObject:[self encodeOptionValuePrototypes:o.possibleValues.allValues] forKey:JSON_POSSIBLE_VALUES];
        [result addObject:temp];
    }
    
    return result;
}

+ (NSArray *)encodeOptionValuePrototypes:(NSArray *)optionValuePrototypes {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:optionValuePrototypes.count];
    NSMutableDictionary *temp;
    
    for (LLOptionValuePrototype *o in optionValuePrototypes) {
        // Only encode selected value, since others can be added (and updated) at run time
        if (o.selected) {
            temp = [[NSMutableDictionary alloc] initWithCapacity:3];
            // displayName and type is not encoded, because they can be got back (and updated) at run time
            [temp setObject:o.key forKey:JSON_KEY];
            [temp setObject:[NSNumber numberWithBool:o.selected] forKey:JSON_SELECTED];
            if (o.value) {
                [temp setObject:o.value forKey:JSON_VALUE];
            }
            [result addObject:temp];
        }
    }
    
    return result;
}

// Transforms an array of optionsPrototypes in json format into a dictionary with key is optionPrototype's key and value is an array of possibleValuePrototypes in json format.
+ (NSDictionary *)optionPrototypeDictFromJsonArray:(NSArray *)jsonArray {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[jsonArray count]];
    for (NSDictionary *d in jsonArray) {
        [result setObject:[d objectForKey:JSON_POSSIBLE_VALUES] forKey:[d objectForKey:JSON_KEY]];
    }
    return result;
}

@end

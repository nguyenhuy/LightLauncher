//
//  LLOptionPrototype.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLOptionValuePrototype;

@interface LLOptionPrototype : NSObject

@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, strong, readonly) NSString *displayName;
// Dictionary of possible values
// Key of the dictionary is the key of LLOptionValuePrototype
// Value of the dictionary is the LLOptionValuePrototype object

// We can alternatively use NSArray.
// But when we want to get a LLOptionValuePrototype, we have to loop and compare.
// So dictionary is better.
@property (nonatomic, strong, readonly) NSDictionary *possibleValues;
@property (nonatomic, readonly) OptionDataType dataType;
@property (nonatomic, readonly) OptionValueType valueType;

- (LLOptionPrototype *)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName andDataType:(OptionDataType)dataType andValueType:(OptionValueType)valueType andPossibleValues:(NSDictionary *)possibleValues;
- (LLOptionValuePrototype *)possibleValueForKey:(NSString *)key;
- (BOOL)containPossibleValueForKey:(NSString *)key;

@end

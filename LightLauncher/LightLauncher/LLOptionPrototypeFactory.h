//
//  LLOptionPrototypeFactory.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLOptionPrototype;

@interface LLOptionPrototypeFactory : NSObject

+ (LLOptionPrototype *)optionPrototypeWithName:(NSString *)name;
+ (LLOptionPrototype *)optionPrototypeWithName:(NSString *)name andDisplayName:(NSString *)displayName andPossibleValue:(NSString *)possibleValue andDisplayPossibleValue:(NSString *)displayPossibleValue;
+ (LLOptionPrototype *)subjectOptionPrototype;
+ (LLOptionPrototype *)bodyOptionPrototype;
+ (LLOptionPrototype *)toAddressesOptionPrototype;
+ (LLOptionPrototype *)ccAddressesOptionPrototype;
+ (LLOptionPrototype *)bccAddressesOptionPrototype;
+ (LLOptionPrototype *)attachmentsOptionPrototype;

@end

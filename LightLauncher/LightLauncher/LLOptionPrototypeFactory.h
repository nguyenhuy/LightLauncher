//
//  LLOptionPrototypeFactory.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLOptionPrototype;

@interface LLOptionPrototypeFactory : NSObject

+ (LLOptionPrototype *)subjectOptionPrototype;
+ (LLOptionPrototype *)bodyOptionPrototype;
+ (LLOptionPrototype *)toAddressesOptionPrototype;
+ (LLOptionPrototype *)ccAddressesOptionPrototype;
+ (LLOptionPrototype *)bccAddressesOptionPrototype;
+ (LLOptionPrototype *)emailsOptionPrototypeWithKey:(NSString *)key andDisplayName:(NSString *)displayName;
+ (LLOptionPrototype *)urlOptionPrototype;

+ (LLOptionPrototype *)fileAttachmentsOptionPrototype;
+ (LLOptionPrototype *)imageOptionPrototype;

+ (LLOptionPrototype *)socialsOptionPrototype;

@end

//
//  LLOptionPrototypeFactory.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/4/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLOptionPrototype;

@interface LLOptionPrototypeFactory : NSObject

+ (LLOptionPrototype *)optionPrototypeWithKey:(NSString *)key;
+ (LLOptionPrototype *)subjectOptionPrototype;
+ (LLOptionPrototype *)bodyOptionPrototype;
+ (LLOptionPrototype *)toAddressesOptionPrototype;
+ (LLOptionPrototype *)ccAddressesOptionPrototype;
+ (LLOptionPrototype *)bccAddressesOptionPrototype;
+ (LLOptionPrototype *)urlAddressesOptionPrototype;

+ (LLOptionPrototype *)fileAttachmentsOptionPrototype;
+ (LLOptionPrototype *)imageAttachmentsOptionPrototype;

+ (LLOptionPrototype *)socialsOptionPrototype;

@end

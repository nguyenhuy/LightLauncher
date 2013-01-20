//
//  LLOptionValuePrototypeFactory.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/5/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLOptionValuePrototype;

@interface LLOptionValuePrototypeFactory : NSObject

+ (LLOptionValuePrototype *)stringOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)emailsOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)urlsOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)urlOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)fileAttachmentsOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)imageAttachmentsOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)pasteboardOptionValuePrototype;
+ (LLOptionValuePrototype *)imageFromCameraRollOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)imagePickLaterOptionValuePrototypeWithDisplayName:(NSString *)displayName;

@end

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
+ (LLOptionValuePrototype *)prefillEmailsPickNowOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)pasteboardOptionValuePrototype;
+ (LLOptionValuePrototype *)imageFromCameraRollOptionValuePrototypeWithDisplayName:(NSString *)displayName;
+ (LLOptionValuePrototype *)imagePickLaterOptionValuePrototypeWithDisplayName:(NSString *)displayName;

@end

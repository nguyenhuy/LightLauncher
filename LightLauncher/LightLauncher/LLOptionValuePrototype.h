//
//  LLOptionValuePrototype.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/5/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@interface LLOptionValuePrototype : NSObject

@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, strong, readonly) NSString *displayName;
@property (nonatomic) BOOL selected;
@property (nonatomic, strong) NSString *value;

- (LLOptionValuePrototype *)initWithKey:(NSString *)key andDisplayName:(NSString *)displayName;

@end

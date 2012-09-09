//
//  LLAttachmentDataOption.h
//  LightLauncher
//
//  Created by Huy Nguyen on 9/9/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOption.h"

@interface LLAttachmentDataOption : LLOption

// param is path to file, data will be loaded when needed
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSString *fileName;

- (id)initWithParam:(NSString *)param AndMimeType:(NSString *)mimeType andFileName:(NSString *)fileName;
- (NSData *)data;

@end

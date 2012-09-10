//
//  LLAttachmentDataOption.h
//  LightLauncher
//
//  Created by Huy Nguyen on 9/9/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLOption.h"

@interface LLAttachmentDataOption : LLOption

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSString *fileName;

- (id)initWithData:(NSData *)data AndMimeType:(NSString *)mimeType AndFileName:(NSString *)fileName;

@end

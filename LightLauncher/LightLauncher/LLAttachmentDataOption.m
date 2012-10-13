//
//  LLAttachmentDataOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 9/9/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLAttachmentDataOption.h"

@implementation LLAttachmentDataOption

- (id)initWithData:(NSData *)data AndMimeType:(NSString *)mimeType AndFileName:(NSString *)fileName {
    self = [super init];
    if (self) {
        self.data = data;
        self.mimeType = mimeType;
        self.fileName = fileName;
    }
    return self;
}

- (NSString *)description {
    return @"AttachmentData";
}

@end

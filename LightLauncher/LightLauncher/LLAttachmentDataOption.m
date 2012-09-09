//
//  LLAttachmentDataOption.m
//  LightLauncher
//
//  Created by Huy Nguyen on 9/9/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#import "LLAttachmentDataOption.h"

@implementation LLAttachmentDataOption

@synthesize mimeType = _mimeType;
@synthesize fileName = _fileName;

- (id)initWithParam:(NSString *)param AndMimeType:(NSString *)mimeType andFileName:(NSString *)fileName {
    self = [super initWithParam:param];
    if (self) {
        self.mimeType = mimeType;
        self.fileName = fileName;
    }
    return self;
}

- (NSData *)data {
    return [NSData dataWithContentsOfFile:self.param];
}

@end

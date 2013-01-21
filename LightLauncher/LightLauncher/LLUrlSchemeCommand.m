//
//  LLUrlSchemeCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/22/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import "LLUrlSchemeCommand.h"

@implementation LLUrlSchemeCommand

- (NSString *)title {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"title must be implemented" userInfo:nil];
}

- (NSURL *)urlScheme {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"rootUrl must be implemented" userInfo:nil];
}

- (NSURL *)constructUrl {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"constructUrl must be implemented" userInfo:nil];
}

- (BOOL)isAppInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[self urlScheme]];
}

#pragma mark Command methods

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    [super executeWithViewController:viewController withCommandDelegate:delegate];
    
    if (![self isAppInstalled]) {
        [self onErrorWithTitle:@"Error" andDesc:@"App is not available"];
    }
    
    NSURL *url = [self constructUrl];
    if (url) {
        //@TODO callback???
        BOOL opened = [[UIApplication sharedApplication] openURL:url];
        if (opened) {
            [self onFinished];
        } else {
            [self onErrorWithTitle:@"Error" andDesc:@"Can't execute the URL Scheme"];
        }
    } else {
        // The url is malformed or empty
        [self onErrorWithTitle:@"Error" andDesc:@"Invalid URL Scheme"];
    }
}

@end

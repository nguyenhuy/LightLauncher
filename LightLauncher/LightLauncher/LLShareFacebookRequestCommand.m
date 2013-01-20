//
//  LLShareFacebookRequestCommand.m
//  LightLauncher
//
//  Created by Huy Nguyen on 1/20/13.
//  Copyright (c) 2013 EarlyBird Lab. All rights reserved.
//

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "LLShareFacebookRequestCommand.h"

@interface LLShareFacebookRequestCommand ()

- (SLRequest *)requestToShareImage;
- (SLRequest *)requestToShareLink;

@end

@implementation LLShareFacebookRequestCommand

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>)delegate {
    [super executeWithViewController:viewController withCommandDelegate:delegate];

    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSDictionary *options = @{ACFacebookAppIdKey : CLIENT_ID_FACEBOOK, ACFacebookPermissionsKey : @[@"publish_stream"], ACFacebookAudienceKey : ACFacebookAudienceFriends};
    [accountStore requestAccessToAccountsWithType:accountType options:options completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *accounts= [accountStore accountsWithAccountType:accountType];
            //@TODO ask user to select an account here, or maybe ask the account identifier in multiple socials command
            ACAccount *account = [accounts lastObject];
            
            SLRequest *request;
            if (self.image) {
                request = [self requestToShareImage];
            } else {
                request = [self requestToShareLink];
            }
            
            [request setAccount:account];
            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                NSLog(@"status code:%d", [urlResponse statusCode]);
                [self onFinished];
            }];
        } else {
            [self onErrorWithTitle:@"Permission Denied" andDesc:@"You did not grant permission to access your Facebook account"];
        }
    }];
}

- (SLRequest *)requestToShareImage {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_FACEBOOK_GRAPH_ROOT, API_FACEBOOK_GRAPH_PHOTOS, nil]];
    
    NSDictionary *params = @{API_FACEBOOK_GRAPH_PARAM_MESSAGE : self.body, API_FACEBOOK_GRAPH_PARAM_LINK : self.url};
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodPOST URL:url parameters:params];
    [request addMultipartData:UIImagePNGRepresentation(self.image) withName:API_FACEBOOK_GRAPH_PARAM_SOURCE type:@"multipart/form-data" filename:@"Image"];
    
    return request;
}

- (SLRequest *)requestToShareLink {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_FACEBOOK_GRAPH_ROOT, API_FACEBOOK_GRAPH_FEED, nil]];

    NSDictionary *params = @{API_FACEBOOK_GRAPH_PARAM_MESSAGE : self.body, API_FACEBOOK_GRAPH_PARAM_LINK : self.url};
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodPOST URL:url parameters:params];
    return request;
}

@end

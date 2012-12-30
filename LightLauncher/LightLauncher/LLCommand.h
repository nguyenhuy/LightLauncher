//
//  LLCommand.h
//  LightLauncher
//
//  Created by Huy Nguyen on 8/26/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

@class LLCommandPrototype;

@protocol LLCommandDelegate <NSObject>

- (void)onFinishedCommand:(id)command;
- (void)onStoppedCommand:(id)command withErrorTitle:(NSString *)title andErrorDesc:(NSString *)desc;

@optional
- (void)onCanceledCommand:(id)command;

@end

@interface LLCommand : NSObject <NSCopying>

// Dict of KVCs that represents options
// Example:
//{
//    "bcc_addresses" =     (
//                           "allforone1511@gmail.com",
//                           "allforone1511@gmail.com"
//                           );
//    body = "Hello LightLauncher";
//    "cc_addresses" =     (
//                          "allforone1511@gmail.com",
//                          "allforone1511@gmail.com"
//                          );
//    "file_attachments" =     (
//                              "mail.png",
//                              "mail.png"
//                              );
//    "service_name" = Email;
//    "service_type" = email;
//    subject = hello;
//    "to_addresses" =     (
//                          "allforone1511@gmail.com",
//                          "allforone1511@gmail.com"
//                          );
//}
@property (nonatomic, strong) NSMutableDictionary *options;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) id<LLCommandDelegate> delegate;

- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;
// Add value to a new or existing array associates with the key
- (void)addValue:(id)value forKey:(NSString *)key;

- (void)executeWithViewController:(UIViewController *)viewController withCommandDelegate:(id<LLCommandDelegate>) delegate;
- (void)onFinished;
- (void)onCanceled;
- (void)onErrorWithTitle:(NSString *)title andDesc:(NSString *)desc;

@end

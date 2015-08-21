//
//  CustomTools.h
//  quanminzhekou
//
//  Created by zxl on 15/4/8.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTools : NSObject

+ (NSString *)md5:(NSString *)str;
+ (BOOL)isEmailAddress:(NSString*)email;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isValidPassword:(NSString*)password;
+ (BOOL)isValidMessageCode:(NSString*)code;
+ (BOOL)isValidInvitationCode:(NSString*)code;
+ (void)simpleAlertShow:(NSString*)title content:(NSString*)content container:(id<UIAlertViewDelegate>)container;

@end

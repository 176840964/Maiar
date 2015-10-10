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
+ (BOOL)is11DigitNumber:(NSString *)mobileNum;
+ (BOOL)isValidPassword:(NSString*)password;
+ (BOOL)isValidMessageCode:(NSString*)code;
+ (void)simpleAlertShow:(NSString*)title content:(NSString*)content container:(id<UIAlertViewDelegate>)container;
+ (void)alertShow:(NSString*)title content:(NSString*)content cancelBtnTitle:(NSString*)cancelTitle okBtnTitle:(NSString*)okTitle container:(id<UIAlertViewDelegate>)container;
+ (NSString *)dateStringFromUnixTimestamp:(NSInteger)timestamp withFormatString:(NSString *)formatStr;
+ (NSString *)weekStringFormIndex:(NSInteger)index;
+ (NSString *)dateStringFromTodayUnixTimestamp:(NSInteger)todayTime andOtherTimestamp:(NSInteger)otherTime;

@end

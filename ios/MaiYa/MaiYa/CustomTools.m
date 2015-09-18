//
//  CustomTools.m
//  quanminzhekou
//
//  Created by zxl on 15/4/8.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CustomTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CustomTools

+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);// This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (BOOL)is11DigitNumber:(NSString *)mobileNum {
    NSString* digitNumber = @"^1\\d{10}";
    NSPredicate* regexTestNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", digitNumber];
    return [regexTestNum evaluateWithObject:mobileNum];
}

+ (BOOL)isValidPassword:(NSString*)password {
    if (![password isKindOfClass:[NSString class]] || 6 > password.length || 20 < password.length) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isValidMessageCode:(NSString*)code {
    if ([code isKindOfClass:[NSString class]] && 6 == code.length) {
        return YES;
    }
    
    return NO;
}

+ (void)simpleAlertShow:(NSString*)title content:(NSString*)content container:(id<UIAlertViewDelegate>)container {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:content
                                                  delegate:container
                                         cancelButtonTitle:@"知道了"
                                         otherButtonTitles:nil];
    [alert show];
}

+ (void)alertShow:(NSString*)title content:(NSString*)content cancelBtnTitle:(NSString*)cancelTitle okBtnTitle:(NSString*)okTitle container:(id<UIAlertViewDelegate>)container {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:content
                                                  delegate:container
                                         cancelButtonTitle:cancelTitle
                                         otherButtonTitles:okTitle, nil];
    [alert show];
}

@end

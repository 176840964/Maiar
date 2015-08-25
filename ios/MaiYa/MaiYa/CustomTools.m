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

//判断邮箱格式
+(BOOL)isEmailAddress:(NSString*)email
{
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        //NSMutableCharacterSet *invalidCharSet = [[[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy]autorelease];
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
            {
                return NO;
            }
        }
        
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
            {
                return NO;
            }
        }
        
        return YES;
    }
    return NO;
}

//判断手机格式
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
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

+ (BOOL)isValidInvitationCode:(NSString*)code {
    if (0 == code.length || 4 <= code.length) {
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

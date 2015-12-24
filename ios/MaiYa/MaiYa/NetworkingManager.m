//
//  NetworkingManager.m
//  MaiYa
//
//  Created by zxl on 15/9/16.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NetworkingManager.h"

@implementation NetworkingManager

+ (NetworkingManager *)shareManager {
    static NetworkingManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSURLCache setSharedURLCache:[[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:40 * 1024 * 1024 diskPath:nil]];
        
        s_instance = [[NetworkingManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        s_instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return s_instance;
}

- (NSURLSessionDataTask *)networkingWithPostMethodPath:(NSString *)path
                                            postParams:(NSDictionary *)postParams
                                               success:(void (^)(id))success {
    NSString *postPath = [NSString stringWithFormat:@"?m=home&c=User&a=%@", path];
    return [self POST:postPath parameters:postParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSString *keyStr in postParams.allKeys) {
            NSString *valueStr = [postParams objectForKey:keyStr];
            [formData appendPartWithFormData:[valueStr dataUsingEncoding:NSUTF8StringEncoding] name:keyStr];
        }
        NSLog(@"postParams:%@", postParams);
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomTools simpleAlertShow:@"出错啦！" content:str container:nil];
            });
        } else {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error:%@", error);
            [[HintView getInstance] presentMessage:@"无网络连接" isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
        });
    }];
}

- (NSURLSessionDataTask *)networkingWithGetMethodPath:(NSString *)path
                                               params:(NSDictionary *)parames
                                              success:(void (^)(id responseObject))success {
    
    return [self GET:@"?" parameters:[self setupParamsByParamesDic:parames andPath:path] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[HintView getInstance] presentMessage:str isAutoDismiss:NO dismissTimeInterval:1 dismissBlock:nil];
            });
        } else {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error:%@", error);
            [[HintView getInstance] presentMessage:@"无网络连接" isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
        });
    }];
}

//修改用户信息相关的上传图片
- (NSURLSessionDataTask*)uploadImageForEditUserInfoWithUid:(NSString*)uid
                                                   userInfoKey:(NSString *)editKey
                                                         image:(UIImage *)image
                                                       success:(void (^)(id responseObject))success {
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    return [self POST:@"?m=home&c=User&a=editUserInfo"
           parameters:@{@"uid": uid}
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:data name:editKey];
    }
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  success(responseObject);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      NSLog(@"error:%@", error);
                      [[HintView getInstance] presentMessage:@"图片上传失败" isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
                  });
    }];
}

#pragma mark -
- (NSDictionary *)setupParamsByParamesDic:(NSDictionary *)paramesDic andPath:(NSString *)path{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"home" forKey:@"m"];
    
    if ([path isEqualToString:@"doalipay"]) {
        [dic setObject:@"Pay" forKey:@"c"];
    } else {
        [dic setObject:@"User" forKey:@"c"];
    }
    
    [dic setObject:path forKey:@"a"];
    [dic setValuesForKeysWithDictionary:paramesDic];
    
    return dic;
}

@end

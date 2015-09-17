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
                                                params:(NSDictionary *)parames
                                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self postWithURLPath:path postParams:parames success:success failure:failure];
}

- (NSURLSessionDataTask *)networkingWithGetMethodPath:(NSString *)path
                                               params:(NSDictionary *)parames
                                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self GET:@"?" parameters:[self setupParamsByParamesDic:parames andPath:path] success:success failure:failure];
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

#pragma mark - post method
- (NSURLSessionDataTask *)postWithURLPath:(NSString *)path
                               postParams:(NSDictionary *)postParams
                                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return [self POST:@"?m=home" parameters:[self setupParamsByParamesDic:postParams andPath:path] success:success failure:failure];
}

@end

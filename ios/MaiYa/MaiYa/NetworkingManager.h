//
//  NetworkingManager.h
//  MaiYa
//
//  Created by zxl on 15/9/16.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AFNetworking.h"

@interface NetworkingManager : AFHTTPSessionManager

+ (NetworkingManager *)shareManager;

/** 
 网络请求接口 
 @param 
    path:方法路径
    params:post参数
    success:成功
    failure:失败
 @return 
    NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)networkingWithPostMethodPath:(NSString *)path
                                            postParams:(NSDictionary *)postParams
                                               success:(void (^)(id responseObject))success;
/**
 网络请求接口
 @param
 path:方法路径
 params:Get参数
 success:成功
 failure:失败
 @return
 NSURLSessionDataTask
 */
//- (NSURLSessionDataTask *)networkingWithGetMethodPath:(NSString *)path
//                                               params:(NSDictionary *)parames
//                                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)networkingWithGetMethodPath:(NSString *)path
                                               params:(NSDictionary *)parames
                                              success:(void (^)(id responseObject))success;



//修改用户信息相关的上传图片
- (NSURLSessionDataTask*)uploadImageForEditUserInfoWithUid:(NSString*)uid
                                               userInfoKey:(NSString *)editKey
                                                     image:(UIImage *)image
                                                   success:(void (^)(id responseObject))success;


@end

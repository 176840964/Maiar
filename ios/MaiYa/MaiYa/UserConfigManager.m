//
//  UserConfigManager.m
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserConfigManager.h"

@implementation UserConfigManager

+ (instancetype)shareManager {
    static UserConfigManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[UserConfigManager alloc] init];
    });
    
    return s_instance;
}

@end

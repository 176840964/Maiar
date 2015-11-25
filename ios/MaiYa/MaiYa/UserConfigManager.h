//
//  UserConfigManager.h
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "CreateOrderViewModel.h"

@interface UserConfigManager : NSObject <NSCoding>

@property (strong, nonatomic) UserInfoViewModel *userInfo;
@property (strong, nonatomic) CreateOrderViewModel *createOrderViewModel;
@property (assign, nonatomic) BOOL isLogin;//是否登录
@property (assign, nonatomic) BOOL isLaunching;//是否刚刚启动应用

@property (copy, nonatomic) NSString *latStr;
@property (copy, nonatomic) NSString *lonStr;

+ (instancetype)shareManager;

- (void)synchronize;
- (void)updatingLocation;//更新定位经纬度

- (void)clearCreateOrderInfo;

@end

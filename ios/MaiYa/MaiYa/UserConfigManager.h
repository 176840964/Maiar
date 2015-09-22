//
//  UserConfigManager.h
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserConfigManager : NSObject <NSCoding>

@property (strong, nonatomic) UserInfoViewModel *userInfo;
@property (assign, nonatomic) BOOL isLogin;

+ (instancetype)shareManager;

- (void)synchronize;
- (void)updatingLocation;//更新定位经纬度

@end

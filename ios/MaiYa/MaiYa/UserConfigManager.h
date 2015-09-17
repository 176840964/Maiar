//
//  UserConfigManager.h
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserConfigManager : NSObject

@property (nonatomic, copy) NSString* userTelNumStr;
@property (strong, nonatomic) UserInfoViewModel *userInfo;

+ (instancetype)shareManager;

@end

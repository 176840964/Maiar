//
//  UserInfoModel.h
//  MaiYa
//
//  Created by zxl on 15/9/17.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface UserInfoModel : BaseModel

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *head;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *token;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface UserInfoViewModel : NSObject <NSCoding>

@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *nickStr;
@property (strong, nonatomic) NSURL *headUrl;
@property (strong, nonatomic) UIImage *sexImage;
@property (copy, nonatomic) NSString *sexStr;
@property (copy, nonatomic) NSString *tokenStr;

- (instancetype)initWithModel:(UserInfoModel *)model;
@end

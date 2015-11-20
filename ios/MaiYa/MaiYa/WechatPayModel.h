//
//  WechatPayModel.h
//  MaiYa
//
//  Created by zxl on 15/11/20.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface WechatPayModel : BaseModel
@property (copy, nonatomic) NSString *appid;
@property (copy, nonatomic) NSString *noncestr;
@property (copy, nonatomic) NSString *package;
@property (copy, nonatomic) NSString *partnerid;
@property (copy, nonatomic) NSString *prepayid;
@property (copy, nonatomic) NSString *timestamp;
@property (copy, nonatomic) NSString *sign;
@end

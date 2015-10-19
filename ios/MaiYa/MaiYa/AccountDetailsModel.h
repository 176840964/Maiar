//
//  AccountDetailsModel.h
//  MaiYa
//
//  Created by zxl on 15/10/19.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface AccountDetailsModel : BaseModel

@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *orderid;
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *ctime;

@end

@interface AccountDetailsViewModel : NSObject

@property (copy, nonatomic) NSString *orderIdStr;
@property (copy, nonatomic) NSString *moneyStr;
@property (copy, nonatomic) NSString *timeStr;
@property (copy, nonatomic) NSString *typeStr;
@property (strong, nonatomic) UIColor *moneyColor;

- (instancetype)initWithAccountDetailsModel:(AccountDetailsModel *)model;

@end

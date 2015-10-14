//
//  ApplyMoneyModel.h
//  MaiYa
//
//  Created by zxl on 15/10/14.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ApplyMoneyModel : BaseModel
@property (copy, nonatomic) NSString *idname;
@property (copy, nonatomic) NSString *balance;
@property (copy, nonatomic) NSString *bankid;
@property (strong, nonatomic) NSNumber *type;
@property (copy, nonatomic) NSString *banktype;
@property (copy, nonatomic) NSString *areaid;
@property (copy, nonatomic) NSString *backname;
@property (copy, nonatomic) NSString *area;

@end

@interface ApplyMoneyViewModel : NSObject
@property (copy, nonatomic) NSString *idNameStr;
@property (copy, nonatomic) NSString *balanceStr;
@property (copy, nonatomic) NSString *bankIdStr;
@property (assign, nonatomic) BOOL isBankPay;
@property (copy, nonatomic) NSString *bankTypeStr;
@property (copy, nonatomic) NSString *areaIdStr;
@property (copy, nonatomic) NSString *backNameStr;
@property (copy, nonatomic) NSString *areaStr;

- (instancetype)initWithApplyMoneyModel:(ApplyMoneyModel *)model;

@end

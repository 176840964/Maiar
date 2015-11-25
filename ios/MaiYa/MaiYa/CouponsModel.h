//
//  CouponsModel.h
//  MaiYa
//
//  Created by zxl on 15/10/14.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, CouponType) {
    CouponTypeOfFullCut,//满减
    CouponTypeOfMinus,//立减
    CouponTypeOfOther//保留状态
};

@interface CouponsModel : BaseModel

@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *money_full;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *etime;
@property (copy, nonatomic) NSString *status;

@end

@interface CouponsViewModel : NSObject

@property (strong, nonatomic) CouponsModel *couponsModel;
@property (copy, nonatomic) NSString *cidStr;
@property (copy, nonatomic) NSString *nameStr;
@property (strong, nonatomic) NSMutableAttributedString *moneyAttrStr;
@property (copy, nonatomic) NSString *moneyFullStr;
@property (copy, nonatomic) NSString *validTimeStr;
@property (copy, nonatomic) NSString *statusStr;
@property (assign, nonatomic) CouponType type;

- (instancetype)initWithCouponsModel:(CouponsModel *)model;

@end

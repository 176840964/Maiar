//
//  CouponsModel.h
//  MaiYa
//
//  Created by zxl on 15/10/14.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface CouponsModel : BaseModel

@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *money_full;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *etime;
@property (copy, nonatomic) NSString *status;

@end

@interface CouponsViewModel : NSObject

@property (copy, nonatomic) NSString *cidStr;
@property (copy, nonatomic) NSString *titleStr;
@property (strong, nonatomic) NSMutableAttributedString *moneyAttrStr;
@property (copy, nonatomic) NSString *moneyFullStr;
@property (copy, nonatomic) NSString *typeStr;
@property (copy, nonatomic) NSString *validTimeStr;
@property (copy, nonatomic) NSString *statusStr;

- (instancetype)initWithCouponsModel:(CouponsModel *)model;

@end

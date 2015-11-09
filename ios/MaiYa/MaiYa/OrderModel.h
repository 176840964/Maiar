//
//  OrderModel.h
//  MaiYa
//
//  Created by zxl on 15/11/5.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel
@property (copy, nonatomic) NSString *orderid;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *problem;
@property (copy, nonatomic) NSString *total;
@property (copy, nonatomic) NSString *order_type;
@property (copy, nonatomic) NSString *service_mode;
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *money_all;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *consultant;
@property (copy, nonatomic) NSString *cname;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *star;

@end

@interface OrderViewModel : NSObject

@property (copy, nonatomic) NSString *orderIdStr;
@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *cidStr;

@property (copy, nonatomic) NSString *timeStr;
@property (copy, nonatomic) NSString *statusStr;
@property (copy, nonatomic) NSString *starStr;
@property (assign, nonatomic) BOOL isFinished;

@property (assign, nonatomic) BOOL isConsultant;
@property (copy, nonatomic) NSString *nameTitleStr;
@property (copy, nonatomic) NSString *nameStr;
@property (copy, nonatomic) NSString *telStr;
@property (copy, nonatomic) NSString *problemStr;
@property (copy, nonatomic) NSString *totalStr;
@property (copy, nonatomic) NSString *serviceModeStr;

@property (copy, nonatomic) NSString *realPriceStr;
@property (copy, nonatomic) NSString *totalPriceStr;

@property (copy, nonatomic) NSString *btn1TitleStr;
@property (strong, nonatomic) UIColor *btn1BgColor;
@property (assign, nonatomic) BOOL isBtn1Hidden;
@property (copy, nonatomic) NSString *btn2TitleStr;
@property (strong, nonatomic) UIColor *btn2BgColor;
@property (assign, nonatomic) BOOL isBtn2Hidden;

- (instancetype)initWithOrderModel:(OrderModel *)model;

@end

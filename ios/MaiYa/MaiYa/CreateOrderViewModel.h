//
//  CreateOrderViewModel.h
//  MaiYa
//
//  Created by zxl on 15/11/13.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserZoneModel.h"
#import "CouponsModel.h"

@interface CreateOrderViewModel : NSObject

//订单基本信息
@property (strong, nonatomic) UserZoneModel *userInfo;
@property (strong, nonatomic) UserZoneModel *masterInfo;
@property (copy, nonatomic) NSString *problemNumStr;
@property (copy, nonatomic) NSString *problemStr;
@property (copy, nonatomic) NSString *servieceModelStr;

//优惠劵
@property (strong, nonatomic) CouponsModel *couponInfo;
@property (assign, nonatomic) BOOL isUsingCoupon;
@property (assign, nonatomic) BOOL isHasCoupons;//是否有优惠劵

//钱
@property (copy, nonatomic) NSString *originalMoneyAllStr;
@property (copy, nonatomic) NSString *moneyAllStr;
@property (copy, nonatomic) NSString *moneyStr;
@property (copy, nonatomic) NSString *totalTimeStr;
@property (copy, nonatomic) NSString *usingBalanceMoneyStr;
@property (assign, nonatomic) BOOL isUsingBalance;
@property (assign, nonatomic) BOOL isNeedThirdPay;

//订单时间
@property (strong, nonatomic) NSMutableDictionary *timeDic;
@property (assign, nonatomic) BOOL isHasSelectedTime;

//提交订单时的参数dictionary
@property (strong, nonatomic) NSMutableDictionary *paraDic;

- (void)clear;

@end

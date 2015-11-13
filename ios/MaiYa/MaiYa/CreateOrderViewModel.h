//
//  CreateOrderViewModel.h
//  MaiYa
//
//  Created by zxl on 15/11/13.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserZoneModel.h"

@interface CreateOrderViewModel : NSObject

@property (strong, nonatomic) UserZoneModel *userInfo;
@property (strong, nonatomic) UserZoneModel *masterInfo;
@property (copy, nonatomic) NSString *problemNumStr;
@property (copy, nonatomic) NSString *problemStr;
@property (copy, nonatomic) NSString *servieceModelStr;
@property (copy, nonatomic) NSString *couponsIdStr;
@property (copy, nonatomic) NSString *moneyAllStr;
@property (copy, nonatomic) NSString *moneyStr;
@property (copy, nonatomic) NSString *totalTimeStr;
@property (copy, nonatomic) NSString *usingBalanceMoneyStr;
@property (strong, nonatomic) NSMutableDictionary *timeDic;

- (void)clear;

@end

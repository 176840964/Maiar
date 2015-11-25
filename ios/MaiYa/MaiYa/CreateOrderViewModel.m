//
//  CreateOrderViewModel.m
//  MaiYa
//
//  Created by zxl on 15/11/13.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "CreateOrderViewModel.h"

@implementation CreateOrderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeDic = [NSMutableDictionary new];
        self.servieceModelStr = @"2";//当前版本只有线下服务方式
        self.isUsingBalance = NO;
        
        [self addObserver:self forKeyPath:@"isUsingBalance" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"isUsingCoupon" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isUsingBalance"];
    [self removeObserver:self forKeyPath:@"isUsingCoupon"];
}

- (void)setProblemNumStr:(NSString *)problemNumStr {
    _problemNumStr = problemNumStr;
    switch (problemNumStr.integerValue) {
        case 46:
            self.problemStr = @"感情";
            break;
            
        case 47:
            self.problemStr = @"事业";
            break;
            
        case 48:
            self.problemStr = @"财富";
            break;
            
        case 49:
            self.problemStr = @"健康";
            break;
            
        case 50:
            self.problemStr = @"学业";
            break;
            
        case 51:
            self.problemStr = @"投资";
            break;
            
        case 52:
            self.problemStr = @"人际";
            break;
            
        case 53:
            self.problemStr = @"运势";
            break;
            
        default:
            self.problemStr = @"综合（从我的收藏中预约）";
            break;
    }
}

- (NSInteger)selectedTimeCount {
    return self.timeDic.count;
}

- (BOOL)isHasCoupons {
    if (nil == self.userInfo) {
        return NO;
    } else {
        return self.userInfo.coupons.boolValue;
    }
}

- (NSMutableDictionary *)paraDic {
    if (nil == _paraDic) {
        _paraDic = [NSMutableDictionary new];
    } else {
        [_paraDic removeAllObjects];
    }
    
    [_paraDic setObject:[UserConfigManager shareManager].userInfo.uidStr forKey:@"uid"];
    [_paraDic setObject:self.masterInfo.uid forKey:@"cid"];
    [_paraDic setObject:self.problemNumStr forKey:@"problem"];
    [_paraDic setObject:self.servieceModelStr forKey:@"service_mode"];
    [_paraDic setObject:self.originalMoneyAllStr forKey:@"money_all"];
    [_paraDic setObject:self.moneyStr forKey:@"money"];
    [_paraDic setObject:self.totalTimeStr forKey:@"total"];
    
    if (self.isUsingBalance) {
        [_paraDic setObject:self.usingBalanceMoneyStr forKey:@"money_balance"];
    }
    
    if (self.couponInfo) {
        [_paraDic setObject:self.couponInfo.cid forKey:@"couponsid"];
    }
    
    NSArray *allKeys = self.timeDic.allKeys;
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return (obj1.integerValue < obj2.integerValue) ? NSOrderedAscending : (obj1.integerValue > obj2.integerValue) ? NSOrderedDescending : NSOrderedSame;
    }];
    
    NSMutableString *timeValueString = nil;
    
    for (NSString *keyStr in allKeys) {
        if (timeValueString.isValid) {
            [timeValueString appendString:@"|"];
        } else {
            timeValueString = [[NSMutableString alloc] init];
        }
        
        NSArray *arr = [self.timeDic objectForKey:keyStr];
        arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return (obj1.integerValue < obj2.integerValue) ? NSOrderedAscending : (obj1.integerValue > obj2.integerValue) ? NSOrderedDescending : NSOrderedSame;
        }];
        
        [timeValueString appendString:keyStr];
        [timeValueString appendString:@"-"];
        
        NSString *timeStr = @"";
        for (NSString *string in arr) {
            if (!timeStr.isValid) {
                timeStr = [NSString stringWithFormat:@"%zd", string.integerValue];
            } else {
                timeStr = [NSString stringWithFormat:@"%@,%zd", timeStr, string.integerValue];
            }
        }
        [timeValueString appendString:timeStr];
    }
    
    [_paraDic setObject:timeValueString forKey:@"ctime"];
    
    
    return _paraDic;
}

- (void)clear {
    self.userInfo = nil;
    self.masterInfo = nil;
//    self.problemNumStr = nil;
//    self.problemStr = nil;
//    self.servieceModelStr = nil;
    self.originalMoneyAllStr = nil;
    self.moneyAllStr = nil;
    self.moneyStr = nil;
    self.totalTimeStr = nil;
    self.usingBalanceMoneyStr = nil;
    self.isUsingBalance = NO;
    [self.timeDic removeAllObjects];
}

#pragma mark - 
- (void)resetPriceMoney {
    NSInteger coupon = 0;
    if (self.isUsingCoupon) {
        coupon = self.couponInfo.money.integerValue;
    } else {
        self.couponInfo = nil;
    }
    
    NSInteger moneyAll = self.originalMoneyAllStr.integerValue - coupon;
    self.moneyAllStr = [NSString stringWithFormat:@"%zd", (0 <= moneyAll) ? moneyAll : 0];
    
    if (self.isUsingBalance) {
        if (self.userInfo.balance.integerValue >= self.moneyAllStr.integerValue) {
            self.usingBalanceMoneyStr = self.moneyAllStr;
            self.moneyStr = @"0";
            self.isNeedThirdPay = NO;
        } else {
            self.isNeedThirdPay = YES;
            self.moneyStr = [NSString stringWithFormat:@"%zd", self.moneyAllStr.integerValue - self.userInfo.balance.integerValue];
            self.usingBalanceMoneyStr = self.userInfo.balance;
        }
    } else {
        self.moneyStr = self.moneyAllStr;
        self.isNeedThirdPay = (self.moneyStr.integerValue != 0);
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isUsingBalance"] || [keyPath isEqualToString:@"isUsingCoupon"]) {
        [self resetPriceMoney];
    }
}

@end

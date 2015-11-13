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
    }
    return self;
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

- (void)clear {
    self.userInfo = nil;
    self.masterInfo = nil;
    self.problemNumStr = nil;
    self.problemStr = nil;
//    self.servieceModelStr = nil;
    self.couponsIdStr = nil;
    self.moneyAllStr = nil;
    self.moneyStr = nil;
    self.totalTimeStr = nil;
    self.usingBalanceMoneyStr = nil;
    [self.timeDic removeAllObjects];
}

@end

//
//  ApplyMoneyModel.m
//  MaiYa
//
//  Created by zxl on 15/10/14.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ApplyMoneyModel.h"

@implementation ApplyMoneyModel

@end

@implementation ApplyMoneyViewModel

- (instancetype)initWithApplyMoneyModel:(ApplyMoneyModel *)model {
    if (self = [super init]) {
        self.idNameStr = [model.idname stringValue];;
        self.balanceStr = [NSString stringWithFormat:@"可提现金%@.00元", model.balance];
        self.bankIdStr = [model.bankid stringValue];
        self.isBankPay = (model.type.integerValue != 1);
        self.bankTypeStr = [model.banktype stringValue];
        self.areaIdStr = [model.areaid stringValue];
        self.backNameStr = [model.backname stringValue];
        self.areaStr = [model.area stringValue];
    }
    
    return self;
}

@end
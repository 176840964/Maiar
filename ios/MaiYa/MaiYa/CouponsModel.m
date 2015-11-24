//
//  CouponsModel.m
//  MaiYa
//
//  Created by zxl on 15/10/14.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "CouponsModel.h"

@implementation CouponsModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super initWithDic:dic];
    if (self) {
        self.cid = [dic objectForKey:@"id"];
    }
    
    return self;
}

@end

@implementation CouponsViewModel

- (instancetype)initWithCouponsModel:(CouponsModel *)model {
    if (self = [super init]) {
        self.couponsModel = model;
        
        self.cidStr = [model.cid stringValue];
        self.titleStr = [model.title stringValue];
        
        NSString *moneyStr = [NSString stringWithFormat:@"￥%.0f", [model.money stringValue].doubleValue / 100];
        self.moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:moneyStr];
        [self.moneyAttrStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:30]} range:NSMakeRange(0, 1)];
        [self.moneyAttrStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:60]} range:NSMakeRange(1, moneyStr.length - 1)];
        
        self.moneyFullStr = [model.money_full stringValue];
        self.typeStr = [model.type stringValue];
        self.validTimeStr = [CustomTools dateStringFromUnixTimestamp:[model.etime stringValue].integerValue withFormatString:@"yyyy-MM-dd hh:mm"];
        self.statusStr = [model.status stringValue];
    }
    
    return self;
}

@end

//
//  AccountDetailsModel.m
//  MaiYa
//
//  Created by zxl on 15/10/19.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "AccountDetailsModel.h"

@implementation AccountDetailsModel

@end


@implementation AccountDetailsViewModel

- (instancetype)initWithAccountDetailsModel:(AccountDetailsModel *)model {
    if (self = [super init]) {
        self.orderIdStr = [NSString stringWithFormat:@"订单号：%@", model.orderid];
        self.timeStr = [CustomTools dateStringFromUnixTimestamp:model.ctime.integerValue withFormatString:@"yyyy年MM月dd日 hh:mm"];
        
        NSString *symbol = @"";
        switch (model.type.integerValue) {
            case 16:
                self.typeStr = @"收入";
                self.moneyColor = [UIColor colorWithHexString:@"#8ccf18"];
                symbol = @"+";
                break;
            case 17:
                self.typeStr = @"支出";
                self.moneyColor = [UIColor colorWithHexString:@"#ff9c00"];
                symbol = @"-";
                break;
            case 18:
                self.typeStr = @"提现";
                self.moneyColor = [UIColor colorWithHexString:@"#ff9c00"];
                symbol = @"-";
                break;
                
            case 19:
                self.typeStr = @"提现失败";
                self.moneyColor = [UIColor colorWithHexString:@"#8ccf18"];
                symbol = @"+";
                break;
                
            case 20:
                self.typeStr = @"违约补偿";
                self.moneyColor = [UIColor colorWithHexString:@"#8ccf18"];
                symbol = @"+";
                break;
                
            case 21:
                self.typeStr = @"订单退款";
                self.moneyColor = [UIColor colorWithHexString:@"#8ccf18"];
                symbol = @"+";
                break;
                
            case 55:
                self.typeStr = @"订单取消";
                self.moneyColor = [UIColor colorWithHexString:@"#ff9c00"];
                symbol = @"-";
                break;
                
            default:
                self.typeStr = @"其他";
                self.moneyColor = [UIColor colorWithHexString:@"#8ccf18"];
                symbol = @"+";
                break;
        }
        
        self.moneyStr = [NSString stringWithFormat:@"%@%.2f", symbol, model.money.doubleValue / 100];
    }
    
    return self;
}

@end
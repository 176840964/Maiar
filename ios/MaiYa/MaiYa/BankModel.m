//
//  BankModel.m
//  MaiYa
//
//  Created by zxl on 15/10/15.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.bid = [dic objectForKey:@"id"];
    }
    
    return self;
}

@end

@implementation BankViewModel

- (instancetype)initWithBankModel:(BankModel*)model {
    if (self = [super init]) {
        self.bankIdStr = [model.bid stringValue];
        self.bankNameStr = [model.name stringValue];
        self.bankOrderStr = [model.order stringValue];
        self.url = [NSURL URLWithString:model.url];
    }
    
    return self;
}

@end
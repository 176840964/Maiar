//
//  MasterListParaModel.m
//  MaiYa
//
//  Created by zxl on 15/11/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "MasterListParaModel.h"

@implementation MasterListParaModel

- (instancetype)initWithCatStr:(NSString *)catStr {
    if (self = [super init]) {
        self.dic = [NSMutableDictionary new];
        
        if ([UserConfigManager shareManager].isLogin) {
            NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
            [self.dic setObject:uid forKey:@"uid"];
        } else {
            NSString *lon = [UserConfigManager shareManager].lonStr;
            NSString *lat = [UserConfigManager shareManager].latStr;
            
            [self.dic setObject:lon forKey:@"longitude"];
            [self.dic setObject:lat forKey:@"latitude"];
        }
        
        self.start = @"0";
        
        self.type = catStr;
        self.distance = @"1";
    }
    
    return self;
}

- (void)setStart:(NSString *)start {
    _start = start;
    [self.dic setObject:_start forKey:@"start"];
}

- (void)setType:(NSString *)type {
    if ([_type isEqualToString:type]) {
        return;
    }
    
    _type = type;
    if ([type isValid]) {
        [self.dic setObject:type forKey:@"type"];
    } else {
        [self.dic removeObjectForKey:@"type"];
    }
}

- (void)setDistance:(NSString *)distance {
    if ([_distance isEqualToString:distance]) {
        return;
    }
    
    _distance = distance;
    if ([distance isValid]) {
        [self.dic setObject:distance forKey:@"distance"];
    } else {
        [self.dic removeObjectForKey:@"distance"];
    }
}

- (void)setOrder:(NSString *)order {
    if ([_order isEqualToString:order]) {
        return;
    }
    
    _order = order;
    if (order.isValid) {
        [self.dic setObject:order forKey:@"order"];
    } else {
        [self.dic removeObjectForKey:@"order"];
    }
}

- (void)setMoney_s:(NSString *)money_s {
    if ([_money_s isEqualToString:money_s]) {
        return;
    }
    
    _money_s = money_s;
    if (money_s.isValid) {
        [self.dic setObject:money_s forKey:@"money_s"];
    } else {
        [self.dic removeObjectForKey:@"money_s"];
    }
    
    self.isChangeMoney_s = YES;
}

- (void)setMoney_e:(NSString *)money_e {
    if ([_money_e isEqualToString:money_e]) {
        return;
    }
    
    _money_e = money_e;
    if (money_e.isValid) {
        [self.dic setObject:money_e forKey:@"money_e"];
    } else {
        [self.dic removeObjectForKey:@"money_e"];
    }
    
    self.isChangeMoney_e = YES;
}

- (void)setTime:(NSString *)time {
    if ([_time isEqualToString:time]) {
        return;
    }
    
    _time = time;
    if (time.isValid) {
        [self.dic setObject:time forKey:@"time"];
    } else {
        [self.dic removeObjectForKey:@"time"];
    }
    
    self.isChangeTime = YES;
}

@end

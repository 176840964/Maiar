//
//  ConsultantTimeModel.m
//  MaiYa
//
//  Created by zxl on 15/10/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ConsultantTimeModel.h"

@implementation ConsultantTimeModel

@end


@implementation ConsultantTimeViewModel

- (instancetype)initWithConsultantTimeModel:(ConsultantTimeModel *)model {
    if (self = [super init]) {
        self.todayTimestampStr = model.today.stringValue;
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSString *keyStr in model.time.allKeys) {
            NSString *valueStr = [model.time objectForKey:keyStr];
            ConsultantDailyViewModel *daily = [[ConsultantDailyViewModel alloc] initWithTimestampStr:keyStr andCustomString:valueStr];
            [arr addObject:daily];
        }
        
        self.dailyArr = [NSArray arrayWithArray:arr];
    }
    
    return self;
}

@end
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
        NSArray *allKeys = [model.time.allKeys sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return NSOrderedDescending;
            } else if ([obj1 integerValue] > [obj2 integerValue]) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
        
        for (NSString *keyStr in allKeys) {
            NSString *valueStr = [model.time objectForKey:keyStr];
            ConsultantDailyViewModel *daily = [[ConsultantDailyViewModel alloc] initWithTimestampStr:keyStr andCustomString:valueStr];
            [arr addObject:daily];
        }
        
        self.dailyArr = [NSArray arrayWithArray:arr];
    }
    
    return self;
}

@end
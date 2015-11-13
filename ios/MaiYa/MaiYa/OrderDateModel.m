//
//  OrderDateModel.m
//  MaiYa
//
//  Created by zxl on 15/11/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "OrderDateModel.h"

@implementation OrderDateModel
- (instancetype)initWithDateString:(NSString *)dateStr {
    if (self = [super init]) {
        NSArray *arr1 = [dateStr componentsSeparatedByString:@"-"];
        NSString *str1 = [arr1 objectAtIndex:0];
        NSString *str2 = [arr1 objectAtIndex:1];
        
        self.dateStr = [CustomTools dateStringFromUnixTimestamp:str1.integerValue withFormatString:@"yyyy年MM月dd日(ww)"];
        
        NSMutableArray *timesArr = [NSMutableArray new];
        NSArray *arr2 = [str2 componentsSeparatedByString:@","];
        for (NSString *sub in arr2) {
            NSString *start = [NSString stringWithFormat:@"%02zd:00", sub.integerValue];
            NSString *end = [NSString stringWithFormat:@"%02zd:00", sub.integerValue + 1];
            NSString *timeStr = [NSString stringWithFormat:@"%@-%@", start, end];
            [timesArr addObject:timeStr];
        }
        
        self.timesArr = [NSArray arrayWithArray:timesArr];
    }
    
    return self;
}

- (instancetype)initWithTimestamp:(NSString *)timestamp andHourArr:(NSArray *)hourArr {
    if (self = [super init]) {
        self.dateStr = [CustomTools dateStringFromUnixTimestamp:timestamp.integerValue withFormatString:@"yyyy年MM月dd日(ww)"];\
        
        NSArray *arr = [hourArr sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
            return ([obj1 integerValue] < [obj2 integerValue]) ? NSOrderedAscending : ([obj1 integerValue] > [obj2 integerValue]) ? NSOrderedDescending : NSOrderedSame;
        }];
        
        NSMutableArray *timesArr = [NSMutableArray new];
        for (NSString *sub in arr) {
            NSString *start = [NSString stringWithFormat:@"%02zd:00", sub.integerValue];
            NSString *end = [NSString stringWithFormat:@"%02zd:00", sub.integerValue + 1];
            NSString *timeStr = [NSString stringWithFormat:@"%@-%@", start, end];
            [timesArr addObject:timeStr];
        }
        
        self.timesArr = [NSArray arrayWithArray:timesArr];
    }
    
    return self;
}

@end

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
            NSString *start = [NSString stringWithFormat:@"%@%@:00", (sub.integerValue > 9)? @"": @"0", sub];
            NSString *end = [NSString stringWithFormat:@"%@%zd:00", (sub.integerValue + 1 > 9)? @"": @"0", sub.integerValue + 1];
            NSString *timeStr = [NSString stringWithFormat:@"%@-%@", start, end];
            [timesArr addObject:timeStr];
        }
        
        self.timesArr = [NSArray arrayWithArray:timesArr];
    }
    
    return self;
}

@end

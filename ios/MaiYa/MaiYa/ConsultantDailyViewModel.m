//
//  ConsultantDailyViewModel.m
//  MaiYa
//
//  Created by zxl on 15/10/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ConsultantDailyViewModel.h"

@implementation ConsultantDailyViewModel

- (instancetype)initWithTimestampStr:(NSString *)timestamp andCustomString:(NSString *)customStr {
    if (self = [super init]) {
        self.timestampStr = timestamp;
        NSString *fullDateStr = [CustomTools dateStringFromUnixTimestamp:self.timestampStr.integerValue withFormatString:@"yyyy年MM月dd日"];
        self.weekStr = [CustomTools dateStringFromUnixTimestamp:self.timestampStr.integerValue withFormatString:@"e"];
        self.weekStr = [CustomTools weekStringFormIndex:self.weekStr.integerValue];
        self.dateStr = [CustomTools dateStringFromUnixTimestamp:self.timestampStr.integerValue withFormatString:@"MM.dd"];
        self.theFullTimeStr = [NSString stringWithFormat:@"%@周%@", fullDateStr, self.weekStr];
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSInteger index = 0; index < customStr.length; ++index) {
            NSString *subStr = [customStr substringWithRange:NSMakeRange(index, 1)];
            [arr addObject:subStr];
        }
        
        self.horlyStateArr = [NSMutableArray arrayWithArray:arr];
    }
    
    return self;
}

@end

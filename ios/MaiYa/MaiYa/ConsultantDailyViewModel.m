//
//  ConsultantDailyViewModel.m
//  MaiYa
//
//  Created by zxl on 15/10/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ConsultantDailyViewModel.h"

@interface ConsultantDailyViewModel ()
@property (strong, nonatomic) NSMutableDictionary *hourlyDic;
@end

@implementation ConsultantDailyViewModel

- (instancetype)initWithTimestampStr:(NSString *)timestamp andCustomString:(NSString *)customStr {
    if (self = [super init]) {
        self.timestampStr = timestamp;
        self.originalHorlyStateStr = customStr;
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

- (BOOL)isNeedToUpdate {
    self.updateHorlyStateStr = @"";
    for (NSString *str in self.horlyStateArr) {
        self.updateHorlyStateStr = [NSString stringWithFormat:@"%@%@", self.updateHorlyStateStr, str];
    }
    
    return ![self.updateHorlyStateStr isEqualToString:self.originalHorlyStateStr];
}

- (NSDictionary *)canSelectHourlyDataDic {
    self.hourlyDic = [NSMutableDictionary new];
    
    NSString *amStr = [self.originalHorlyStateStr substringWithRange:NSMakeRange(9, 3)];
    [self addSectionHourlyArrToDicByKey:@"0" setionStr:amStr offsetHour:9];
    
    NSString *pmStr = [self.originalHorlyStateStr substringWithRange:NSMakeRange(13, 5)];
    [self addSectionHourlyArrToDicByKey:@"1" setionStr:pmStr offsetHour:13];
    
    NSString *nightStr = [self.originalHorlyStateStr substringWithRange:NSMakeRange(19, 4)];
    [self addSectionHourlyArrToDicByKey:@"2" setionStr:nightStr offsetHour:19];
    
    return self.hourlyDic;
}

#pragma mark - 
- (void)addSectionHourlyArrToDicByKey:(NSString *)key setionStr:(NSString *)sectionStr offsetHour:(NSInteger)offsetHour {
    NSMutableArray *arr = nil;
    
    for (NSInteger index = 0; index < sectionStr.length; index ++) {
        NSString *subStr = [sectionStr substringWithRange:NSMakeRange(index, 1)];
        if ([subStr isEqualToString:@"1"]) {
            NSString *start = [NSString stringWithFormat:@"%02zd", offsetHour + index];
            NSString *end = [NSString stringWithFormat:@"%02zd", offsetHour + 1 + index];
            NSString *hour = [NSString stringWithFormat:@"%@:00-%@:00", start, end];
            if (!arr) {
                arr = [NSMutableArray new];
            }
            [arr addObject:hour];
        }
    }
    
    if (arr) {
        [self.hourlyDic setObject:arr forKey:key];
    }
}

@end

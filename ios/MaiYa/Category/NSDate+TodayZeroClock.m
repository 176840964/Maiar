//
//  NSDate+TodayZeroClock.m
//  MaiYa
//
//  Created by zxl on 15/11/11.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "NSDate+TodayZeroClock.h"

@implementation NSDate (TodayZeroClock)

+ (NSDate *)todayZeroClock {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSString *string = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *zeroClockDate = [dateFormatter dateFromString:string];
    
    return zeroClockDate;
}

@end

//
//  ConsultantDailyViewModel.h
//  MaiYa
//
//  Created by zxl on 15/10/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultantDailyViewModel : NSObject

@property (copy, nonatomic) NSString *timestampStr;
@property (copy, nonatomic) NSString *theFullTimeStr;
@property (copy, nonatomic) NSString *weekStr;
@property (copy, nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSMutableArray *horlyStateArr;
@property (copy, nonatomic) NSString *originalHorlyStateStr;
@property (copy, nonatomic) NSString *updateHorlyStateStr;
@property (assign, nonatomic) BOOL isNeedToUpdate;

- (NSDictionary *)canSelectHourlyDataDic;

- (instancetype)initWithTimestampStr:(NSString *)timestamp andCustomString:(NSString *)customStr;
@end

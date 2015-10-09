//
//  ConsultantDailyViewModel.h
//  MaiYa
//
//  Created by zxl on 15/10/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultantDailyViewModel : NSObject

@property (copy, nonatomic) NSString *theFullTimeStr;
@property (copy, nonatomic) NSString *timestampStr;
@property (strong, nonatomic) NSArray *horlyStateArr;

- (instancetype)initWithTimestampStr:(NSString *)timestamp andCustomString:(NSString *)customStr;
@end

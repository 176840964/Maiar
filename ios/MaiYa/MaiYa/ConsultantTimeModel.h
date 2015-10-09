//
//  ConsultantTimeModel.h
//  MaiYa
//
//  Created by zxl on 15/10/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"
#import "ConsultantDailyViewModel.h"

@interface ConsultantTimeModel : BaseModel

@property (strong, nonatomic) NSNumber *today;
@property (strong, nonatomic) NSDictionary *time;

@end

@interface ConsultantTimeViewModel : NSObject

@property (copy, nonatomic) NSString *todayTimestampStr;
@property (strong, nonatomic) NSArray *dailyArr;

- (instancetype)initWithConsultantTimeModel:(ConsultantTimeModel *)model;

@end

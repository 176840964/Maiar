//
//  WorkingDateCell.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultantDailyViewModel.h"

@interface WorkingDateCell : UIControl
@property (strong, nonatomic) ConsultantDailyViewModel *dailyViewModel;

- (void)layoutWorkingDateCellSubviewsByDailyViewModel:(ConsultantDailyViewModel *)dailyViewModel;

@end

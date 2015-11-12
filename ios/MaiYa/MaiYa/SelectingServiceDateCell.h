//
//  SelectingServiceDateCell.h
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultantDailyViewModel.h"

@interface SelectingServiceDateCell : UIControl

@property (strong, nonatomic) ConsultantDailyViewModel *dailyViewModel;

- (void)layoutSelectingServiceDateCellSubviewsByConsultantDailyViewModel:(ConsultantDailyViewModel *)dailyViewModel;

@end

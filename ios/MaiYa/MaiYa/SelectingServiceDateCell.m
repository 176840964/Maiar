//
//  SelectingServiceDateCell.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "SelectingServiceDateCell.h"

@interface SelectingServiceDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *weekLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@end

@implementation SelectingServiceDateCell

- (void)layoutSelectingServiceDateCellSubviewsByConsultantDailyViewModel:(ConsultantDailyViewModel *)dailyViewModel {
    self.dailyViewModel = dailyViewModel;
    self.weekLab.text = dailyViewModel.weekStr;
    self.dateLab.text = dailyViewModel.dateStr;
}


@end

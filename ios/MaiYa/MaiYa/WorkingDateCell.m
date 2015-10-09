//
//  WorkingDateCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WorkingDateCell.h"

@interface WorkingDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *weekLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@end

@implementation WorkingDateCell

- (void)layoutWorkingDateCellSubviewsByDailyViewModel:(ConsultantDailyViewModel *)dailyViewModel {
    self.dailyViewModel = dailyViewModel;
    self.weekLab.text = dailyViewModel.weekStr;
    self.dateLab.text = dailyViewModel.dateStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

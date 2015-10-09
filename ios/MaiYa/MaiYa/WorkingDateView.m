//
//  WorkingDateView.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WorkingDateView.h"
#import "WorkingDateCell.h"

@interface WorkingDateView ()
@property (strong, nonatomic) IBOutletCollection(WorkingDateCell) NSArray *dateArr;
@property (weak, nonatomic) IBOutlet UILabel *selectedLab;
@end

@implementation WorkingDateView

- (void)layoutWorkingDateViewSubviewsByDateArr:(NSArray *)arr {
    self.dateArr = [self.dateArr sortByUIViewOriginX];
    
    for (NSInteger index = 0; index < self.dateArr.count; ++index) {
        ConsultantDailyViewModel *dailyViewModel = [arr objectAtIndex:index];
        WorkingDateCell *cell = [self.dateArr objectAtIndex:index];
        [cell layoutWorkingDateCellSubviewsByDailyViewModel:dailyViewModel];
        [cell addTarget:self action:@selector(onTapWorkingDateCell:) forControlEvents:UIControlEventTouchUpInside];
        
        if (0 == index) {
            [self onTapWorkingDateCell:cell];
        }
    }
}

#pragma mark -
- (void)onTapWorkingDateCell:(WorkingDateCell *)dateCell {
    if (self.selectedDateHandle) {
        for (WorkingDateCell * cell in self.dateArr) {
            if ([cell isEqual:dateCell]) {
                cell.backgroundColor = [UIColor colorWithHexString:@"#f85958"];
                self.selectedLab.text = cell.dailyViewModel.theFullTimeStr;
                self.selectedDateHandle([NSNumber numberWithInteger:[self.dateArr indexOfObject:cell]]);
            } else {
                cell.backgroundColor = [UIColor colorWithHexString:@"#7167aa"];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

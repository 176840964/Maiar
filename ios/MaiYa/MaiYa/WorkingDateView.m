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

- (void)layoutWorkingDateViewSubviews {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

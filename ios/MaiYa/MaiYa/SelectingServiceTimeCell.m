//
//  SelectingServiceDateCell.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "SelectingServiceTimeCell.h"

@interface SelectingServiceTimeCell ()
@end

@implementation SelectingServiceTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.markImage.image = [UIImage imageNamed:_isSelected ? @"advisory_date_select1" : @"advisory_date_select0"];
}

@end

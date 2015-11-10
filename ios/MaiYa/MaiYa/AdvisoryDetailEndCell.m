//
//  AdvisoryDetailEndCell.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailEndCell.h"

@implementation AdvisoryDetailEndCell

- (void)awakeFromNib {
    // Initialization code
    
    self.straImagesArr = [self.straImagesArr sortByUIViewOriginX];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AdvisoryDetailPayCell1.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailPayCell1.h"

@implementation AdvisoryDetailPayCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onTapCommitBtn:(id)sender {
    if (self.tapCommitBtnHandle) {
        self.tapCommitBtnHandle();
    }
}

@end

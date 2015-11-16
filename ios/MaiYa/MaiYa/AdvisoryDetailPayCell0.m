//
//  AdvisoryDetailPayCell0.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailPayCell0.h"

@implementation AdvisoryDetailPayCell0

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - IBAction
- (IBAction)onTapCommitBtn:(id)sender {
    if (self.tapCommitBtnHandle) {
        self.tapCommitBtnHandle();
    }
}

- (IBAction)useBalanceSwitchValueChange:(id)sender {
    [UserConfigManager shareManager].createOrderViewModel.isUsingBalance = ![UserConfigManager shareManager].createOrderViewModel.isUsingBalance;
}

@end

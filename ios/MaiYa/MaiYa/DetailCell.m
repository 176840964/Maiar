//
//  DetailCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeStrLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@end

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutDetailCellSubviewsByAccountDetailsViewModel:(AccountDetailsViewModel *)viewModel {
    self.typeStrLab.text = viewModel.typeStr;
    self.dateLab.text = viewModel.timeStr;
    self.orderIdLab.text = viewModel.orderIdStr;
    self.moneyLab.text = viewModel.moneyStr;
    self.moneyLab.textColor = viewModel.moneyColor;
}

@end

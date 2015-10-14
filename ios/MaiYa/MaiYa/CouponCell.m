//
//  CouponCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;
@end

@implementation CouponCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutCouponCellSubviewsByCouponsViewModel:(CouponsViewModel *)viewModel {
    self.priceLab.attributedText = viewModel.moneyAttrStr;
    self.titleLab.text = viewModel.titleStr;
    self.dateLab.text = viewModel.validTimeStr;
}

@end

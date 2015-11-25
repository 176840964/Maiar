//
//  CouponCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
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
    self.titleLab.text = viewModel.nameStr;
    self.dateLab.text = viewModel.validTimeStr;
}

- (void)setIsCanUse:(BOOL)isCanUse {
    _isCanUse = isCanUse;
    if (_isCanUse) {
        self.bgImgView.image = [UIImage imageNamed:@"couponBg"];
    } else {
        self.bgImgView.image = [UIImage imageNamed:@"coupon_non_selected_bg"];
    }
}

@end

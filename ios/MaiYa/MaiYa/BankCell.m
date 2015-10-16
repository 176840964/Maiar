//
//  BackCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BankCell.h"

@interface BankCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end

@implementation BankCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutBankCellSubviewsByBankViewModel:(BankViewModel *)viewModel {
    self.titleLab.text = viewModel.bankNameStr;
    [self.iconImageView setImageWithURL:viewModel.url placeholderImage:[UIImage imageNamed:@""]];
    self.selectedImageView.hidden = YES;
}

- (void)layoutBankCellSubviewsByAreaViewModel:(AreaViewModel *)viewModel {
    self.titleLab.text = viewModel.areaNameStr;
    self.selectedImageView.hidden = YES;
}

@end

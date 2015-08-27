//
//  MasterCell.m
//  MaiYa
//
//  Created by zxl on 15/8/27.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MasterCell.h"

@interface MasterCell ()
@property (nonatomic, weak) IBOutlet UIImageView *headImageView;
@property (nonatomic, weak) IBOutlet UIImageView *sexImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLab;
@property (nonatomic, weak) IBOutlet UILabel *workAgeLab;
@property (nonatomic, weak) IBOutlet UILabel *markLab1;
@property (nonatomic, weak) IBOutlet UILabel *markLab2;
@property (nonatomic, weak) IBOutlet UILabel *markLab3;
@property (nonatomic, weak) IBOutlet UILabel *evaluationLab;
@property (nonatomic, weak) IBOutlet UILabel *evaluationCountLab;
@property (nonatomic, weak) IBOutlet UILabel *locationLab;
@property (nonatomic, weak) IBOutlet UILabel *priceLab;

@end

@implementation MasterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

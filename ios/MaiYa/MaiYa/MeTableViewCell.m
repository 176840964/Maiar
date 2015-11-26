//
//  MeTableViewCell.m
//  MaiYa
//
//  Created by zxl on 15/11/26.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "MeTableViewCell.h"

@interface MeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end

@implementation MeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubViewByDic:(NSDictionary *)dic {
    self.iconImageView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    self.titleLab.text = [dic objectForKey:@"title"];
}

@end

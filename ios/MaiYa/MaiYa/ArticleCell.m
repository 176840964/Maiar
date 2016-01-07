//
//  ArticleCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "ArticleCell.h"

@interface ArticleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *digestLab;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *readLab;
@property (weak, nonatomic) IBOutlet UILabel *praiseLab;
@end

@implementation ArticleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutArticleCellSubviewsByArticleViewModel:(ArticleViewModel *)viewModel {
    [self.iconImgView setImageWithURL:viewModel.imgUrl placeholderImage:[UIImage imageNamed:viewModel.defulteImgStr]];
    self.titleLab.text = viewModel.titleStr;
    self.digestLab.text = viewModel.digestStr;
    self.nickLab.text = viewModel.nickStr;
    self.timeLab.text = viewModel.timestampStr;
    self.readLab.text = viewModel.readStr;
    self.praiseLab.text = viewModel.praiseStr;
}

@end

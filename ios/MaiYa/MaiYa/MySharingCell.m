//
//  MySharingCell.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MySharingCell.h"

@interface MySharingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *articleIconView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *articleContentLab;
@property (weak, nonatomic) IBOutlet UILabel *articleDateLab;
@property (weak, nonatomic) IBOutlet UILabel *articleReadLab;
@property (weak, nonatomic) IBOutlet UILabel *articleGoodLab;
@property (weak, nonatomic) IBOutlet UIButton *articleDelBtn;
@end

@implementation MySharingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutMySharingCellSubviewsByArticleViewModel:(ArticleViewModel *)articleViewModel {
    [self.articleIconView setImageWithURL:articleViewModel.imgUrl placeholderImage:[UIImage imageNamed:@"aboutIcon"]];
    self.articleTitleLab.text = articleViewModel.titleStr;
    self.articleContentLab.text = articleViewModel.digestStr;
    self.articleDateLab.text = articleViewModel.timestampStr;
    self.articleReadLab.text = articleViewModel.readStr;
    self.articleGoodLab.text = articleViewModel.praiseStr;
}

#pragma mark - IBAction
- (IBAction)onTapArticleDelBtn:(id)sender {
    
}

@end

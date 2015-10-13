//
//  CommentCell.m
//  MaiYa
//
//  Created by zxl on 15/9/10.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *userLab;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *starArr;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@end

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    self.starArr = [self.starArr sortByUIViewOriginX];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutCommentCellSubviewsByCommentViewModel:(CommentViewModel *)viewModel {
    self.dateLab.text = viewModel.ctimeStr;
    self.userLab.text = viewModel.usernameStr;
    self.contentLab.text = viewModel.contentStr;
    
    for (NSInteger index = 0; index < self.starArr.count; ++index) {
        UIImageView *imageView = [self.starArr objectAtIndex:index];
        if (viewModel.starCountStr.integerValue > index) {
            imageView.image = [UIImage imageNamed:@"smallStar1"];
        } else {
            imageView.image = [UIImage imageNamed:@"smallStar0"];
        }
    }
}

@end

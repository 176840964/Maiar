//
//  AdvisoryDetailCommentCell.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailCommentCell.h"

@implementation AdvisoryDetailCommentCell

- (void)awakeFromNib {
    // Initialization code
    
    self.starBtnsArr = [self.starBtnsArr sortByUIViewOriginX];
    self.selectedStarCountStr = @"5";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - IBAction
- (IBAction)onTapStarBtn:(id)sender {
    UIButton *tapBtn = (UIButton *)sender;
    self.selectedStarCountStr = [NSString stringWithFormat:@"%zd", tapBtn.tag];
    
    for (NSInteger index = 0; index < self.starBtnsArr.count; index ++) {
        UIButton *btn = [self.starBtnsArr objectAtIndex:index];
        if (index < tapBtn.tag) {
            [btn setImage:[UIImage imageNamed:@"bigStar1"] forState:UIControlStateNormal];
        } else {
            [btn setImage:[UIImage imageNamed:@"bigStar0"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)onTapCommitComment:(id)sender {
    if (self.tapCommitCommentHandler) {
        self.tapCommitCommentHandler();
    }
}

@end

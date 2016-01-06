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

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSLog(@"textView.text:%@(%zd)", textView.text, textView.text.length);
//    NSLog(@"replacementText:%@(%zd)", text, text.length);
//    NSLog(@"range:%@", NSStringFromRange(range));
    
    NSInteger count;
    if (text.isValid) {//replacementText有效->增加字数
        count = textView.text.length + text.length;
    } else if(!text.isValid && textView.text.isValid) {//replacementText无效+textView.text有效->减少字数
        count = textView.text.length - 1;
    } else {//同时无效->清空textView
        count = 0;
    }
    
    NSString *string = [NSString stringWithFormat:@"(还可以输入%zd字)", 140 - count];
    if (140 - count < 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor colorWithR:197 g:199 b:199]} range:NSMakeRange(0, 6)];
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(6, string.length - 6 - 2)];
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor colorWithR:197 g:199 b:199]} range:NSMakeRange(string.length - 2, 2)];
        self.countLab.attributedText = attributedString;
    } else {
        self.countLab.text = string;
    }
    
    return YES;
}

@end

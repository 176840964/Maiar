//
//  PlazaCell.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaCell.h"

@interface PlazaCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@end

@implementation PlazaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutPlazaCellSubviewsByArr:(NSArray *)arr {
    [self.btn1 setTitle:[arr objectAtIndex:0] forState:UIControlStateNormal];
    [self.btn2 setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
    [self.btn3 setTitle:[arr objectAtIndex:2] forState:UIControlStateNormal];
}

#pragma mark - IBAction
- (IBAction)onTapBtn:(id)sender {
    if (self.tapBtnHandler) {
        UIButton *btn = (UIButton *)sender;
        self.tapBtnHandler([NSNumber numberWithInteger:btn.tag]);
    }
    
}

@end

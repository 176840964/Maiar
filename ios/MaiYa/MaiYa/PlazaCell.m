//
//  PlazaCell.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaCell.h"
#import "ArticleIndexModel.h"

@interface PlazaCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (strong, nonatomic) ArticleDirectoryViewModel *viewModel;
@end

@implementation PlazaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutPlazaCellSubviewsByAritcleDirectoryViewModel:(ArticleDirectoryViewModel *)viewModel {
    self.viewModel = viewModel;
    NSArray *dataArr = viewModel.dataArr;
    self.btn1.hidden = YES;
    self.btn2.hidden = YES;
    self.btn3.hidden = YES;
    
    for (NSInteger index = 0; index < dataArr.count; ++ index) {
        ArticleIndexViewModel *indexViewModel = [dataArr objectAtIndex:index];
        if (0 == index) {
            self.btn1.hidden = NO;
            [self.btn1 setTitle:indexViewModel.titleStr forState:UIControlStateNormal];
        } else if (1 == index) {
            self.btn2.hidden = NO;
            [self.btn2 setTitle:indexViewModel.titleStr forState:UIControlStateNormal];
        } else {
            self.btn3.hidden = NO;
            [self.btn3 setTitle:indexViewModel.titleStr forState:UIControlStateNormal];
        }
    }
}

#pragma mark - IBAction
- (IBAction)onTapBtn:(id)sender {
    if (self.tapBtnHandler) {
        UIButton *btn = (UIButton *)sender;
        
        ArticleIndexViewModel* indexViewModel = [self.viewModel.dataArr objectAtIndex:btn.tag];
        
        self.tapBtnHandler(self.viewModel.typeStr, indexViewModel.aidStr, indexViewModel.titleStr);
    }
}

- (IBAction)onTapCategoreBtn:(id)sender {
    if (self.tapCategoryBtnHandle) {
        self.tapCategoryBtnHandle(self.viewModel.typeStr);
    }
}

@end

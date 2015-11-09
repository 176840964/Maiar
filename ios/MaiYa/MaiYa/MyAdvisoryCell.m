//
//  MyAdvisoryCell.m
//  MaiYa
//
//  Created by zxl on 15/11/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyAdvisoryCell.h"

@interface MyAdvisoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *problemLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *serviceModeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *finishAdvisoryLab;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *starArr;
@end

@implementation MyAdvisoryCell

- (void)awakeFromNib {
    // Initialization code
    
    self.starArr = [self.starArr sortByUIViewOriginX];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutMyAdvisorySubviewsByOrderViewModel:(OrderViewModel *)viewModel {
    self.dateLab.text = viewModel.timeStr;
    
    for (NSInteger index = 0; index < self.starArr.count; index ++) {
        UIImageView *imageView = [self.starArr objectAtIndex:index];
        imageView.hidden = !viewModel.isFinished;
        
        if (index < viewModel.starStr.integerValue) {
            imageView.image = [UIImage imageNamed:@"smallStar1"];
        } else {
            imageView.image = [UIImage imageNamed:@"smallStar0"];
        }
    }
    
    self.finishAdvisoryLab.hidden = !viewModel.isFinished;
    self.stateLab.hidden = viewModel.isFinished;
    self.stateLab.text = viewModel.statusStr;
    self.finishAdvisoryLab.text = viewModel.statusStr;
    
    self.nameTitleLab.text = viewModel.nameTitleStr;
    self.nameLab.text = viewModel.nameStr;
    self.problemLab.text = viewModel.problemStr;
    self.timeLab.text = viewModel.totalStr;
    self.serviceModeLab.text = viewModel.serviceModeStr;
    self.priceLab.text = viewModel.totalPriceStr;
    [self.btn1 setTitle:viewModel.btn1TitleStr forState:UIControlStateNormal];
    self.btn1.backgroundColor = viewModel.btn1BgColor;
    self.btn1.hidden = viewModel.isBtn1Hidden;
    
    [self.btn2 setTitle:viewModel.btn2TitleStr forState:UIControlStateNormal];
    self.btn2.backgroundColor = viewModel.btn2BgColor;
    self.btn2.hidden = viewModel.isBtn2Hidden;
}

@end

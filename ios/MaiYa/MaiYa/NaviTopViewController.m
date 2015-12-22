//
//  NaviTopViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NaviTopViewController.h"

@interface NaviTopViewController ()
@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UILabel *titleLab;
@property (nonatomic, weak) IBOutlet UIButton *rightBtn;
@property (nonatomic, weak) IBOutlet UIButton *rightSecondBtn;
@end

@implementation NaviTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backBtn setTitle:self.backBtnTitle forState:UIControlStateNormal];
    self.backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleLab.text = self.titleLabStr;
    
    [self layoutRightBtn:self.rightBtn withBtnTitle:self.rightBtnImgStr];
    [self layoutRightBtn:self.rightSecondBtn withBtnTitle:self.rightSecondBtnImgStr];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


#pragma mark -
- (void)layoutRightBtn:(UIButton *)btn withBtnTitle:(NSString *)str;{
    if (str.isValid) {
        btn.hidden = NO;
        [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    } else {
        btn.hidden = YES;
    }
}

#pragma mark - IBAction
- (IBAction)onTapBackBtn:(id)sender {
    if (self.tapBackBtnHandler) {
        self.tapBackBtnHandler();
    }
}

- (IBAction)onTapRightBtn:(id)sender {
    if (self.tapRightBtnHandler) {
        self.tapRightBtnHandler();
    }
}

- (IBAction)onTapRightSecondBtn:(id)sender {
    if (self.tapRightSecondBtnHandler) {
        self.tapRightSecondBtnHandler();
    }
}

@end

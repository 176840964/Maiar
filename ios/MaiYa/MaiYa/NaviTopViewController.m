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
@end

@implementation NaviTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backBtn setTitle:self.backBtnTitle forState:UIControlStateNormal];
    self.backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleLab.text = self.titleLabStr;
    
    if (0 != self.rightBtnImgStr.length && [self.rightBtnImgStr isKindOfClass:[NSString class]]) {
        self.rightBtn.hidden = NO;
        [self.rightBtn setImage:[UIImage imageNamed:self.rightBtnImgStr] forState:UIControlStateNormal];
    } else {
        self.rightBtn.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


#pragma mark -

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

@end

//
//  WithdrawalViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WithdrawalViewController.h"

@interface WithdrawalViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *markView;
@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.widthConstraint.constant = self.view.width * 2;
}

#pragma mark - IBAction
- (IBAction)onTapZhifubaoBtn:(id)sender {
    self.markView.transform = CGAffineTransformIdentity;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)onTapBankCardBtn:(id)sender {
    self.markView.transform = CGAffineTransformMakeTranslation(self.view.width / 2.0, 0);
    [self.scrollView setContentOffset:CGPointMake(self.view.width, 0) animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (0 == scrollView.contentOffset.x) {
        self.markView.transform = CGAffineTransformIdentity;
    } else {
        self.markView.transform = CGAffineTransformMakeTranslation(self.view.width / 2.0, 0);
    }
}

@end

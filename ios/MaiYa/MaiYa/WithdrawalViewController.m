//
//  WithdrawalViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "ApplyMoneyModel.h"

@interface WithdrawalViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *markView;

//zhifubao
@property (weak, nonatomic) IBOutlet UITextField *aliAccoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *aliNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *aliMoneyTextField;

//bank
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;
@property (weak, nonatomic) IBOutlet UILabel *bankAddrLab;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankUserNameField;
@property (weak, nonatomic) IBOutlet UITextField *bankMoneyTextField;

@property (strong, nonatomic) ApplyMoneyViewModel *applyMoneyViewModel;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getApplyMoney];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.widthConstraint.constant = self.view.width * 2;
}

#pragma mark - 
- (void)layoutSubviews {
    if (self.applyMoneyViewModel.isBankPay) {
        [self onTapBankCardBtn:nil];
    } else {
        [self onTapZhifubaoBtn:nil];
    }
    
    self.aliMoneyTextField.placeholder = self.applyMoneyViewModel.balanceStr;
    self.bankMoneyTextField.placeholder = self.applyMoneyViewModel.balanceStr;
}

#pragma mark - NetWorking
- (void)getApplyMoney {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid
    uid = @"1";
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"getApplyMoney" params:@{@"uid": uid} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        ApplyMoneyModel *model = [[ApplyMoneyModel alloc] initWithDic:resDic];
        self.applyMoneyViewModel = [[ApplyMoneyViewModel alloc] initWithApplyMoneyModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutSubviews];
        });
    }];
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

- (IBAction)onTapZhifubaoCommitBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowCommitSuccessViewController" sender:self];
}

- (IBAction)onTapBankCommitBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowCommitSuccessViewController" sender:self];
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

//
//  MyWalletViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyWalletViewController.h"
#import "CouponCell.h"
#import "UserZoneModel.h"
#import "WalletInfoView.h"

@interface MyWalletViewController () <UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightWalletInfoView;
@property (weak, nonatomic) IBOutlet UIScrollView *walletInfoScrollView;
@property (weak, nonatomic) IBOutlet WalletInfoView *walletInfoView;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *noneCouponImageView;
@property (weak, nonatomic) IBOutlet UIButton *walletRuleBtn;

@property (strong, nonatomic) UserZoneViewModel *userZoneViewModel;
@property (strong, nonatomic) NSMutableArray *couponsArr;
@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self getUserInfo];
    [self getUserCoupons];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.widthConstraint.constant = self.view.width * 2;
    self.heightWalletInfoView.constant = CGRectGetMaxY(self.walletRuleBtn.frame) + 20;
}

#pragma mark - 
- (void)layoutWalletInfoView {
    self.walletInfoView.balanceLab.format = @"%.2f";
    NSLog(@"%f", self.userZoneViewModel.balanceStr.doubleValue);
    NSLog(@"%f", self.userZoneViewModel.balanceStr.floatValue);
    [self.walletInfoView.balanceLab countFrom:0 to:self.userZoneViewModel.balanceStr.doubleValue withDuration:2.0];
//    self.walletInfoView.balanceLab.text = self.userZoneViewModel.balanceStr;
    self.walletInfoView.totalIncomeLab.text = self.userZoneViewModel.incomeStr;
    self.walletInfoView.totalWithdrawalsLab.text = self.userZoneViewModel.withdrawalsStr;
    
    self.walletInfoView.comingSoonMoneyLab.text = self.userZoneViewModel.soonMoneyStr;
    CGRect rect = [self.walletInfoView.comingSoonMoneyLab textRectForBounds:self.walletInfoView.comingSoonMoneyLab.bounds limitedToNumberOfLines:1];
    self.walletInfoView.comingSoonMoneyLab.width  = CGRectGetWidth(rect);
    self.walletInfoView.comingSoonMoneyLab.x = (self.view.width - CGRectGetWidth(rect)) / 2.0;
    self.walletInfoView.comingSoonIcon.x = self.walletInfoView.comingSoonMoneyLab.x - self.walletInfoView.comingSoonIcon.width - 5;
}

#pragma mark - Networking
- (void)getUserInfo {
    NSString *cid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userInfo" params:@{@"cid": cid} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        UserZoneModel *model = [[UserZoneModel alloc] initWithDic:resDic];
        self.userZoneViewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutWalletInfoView];
        });
    }];
}

- (void)getUserCoupons {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"couponsList" params:@{@"uid": uid} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        self.couponsArr = [NSMutableArray new];
        for (NSDictionary *dic in resArr) {
            CouponsModel *model = [[CouponsModel alloc] initWithDic:dic];
            CouponsViewModel *viewModel = [[CouponsViewModel alloc] initWithCouponsModel:model];
            [self.couponsArr addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (0 == self.couponsArr.count) {
                self.tableView.hidden = YES;
                self.noneCouponImageView.hidden = NO;
            } else {
                self.tableView.hidden = NO;
                self.noneCouponImageView.hidden = YES;
                [self.tableView reloadData];
            }
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapInfoBtn:(id)sender {
    self.markView.transform = CGAffineTransformIdentity;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)onTapCouponBtn:(id)sender {
    self.markView.transform = CGAffineTransformMakeTranslation(self.view.width / 2.0, 0);
    [self.scrollView setContentOffset:CGPointMake(self.view.width, 0) animated:YES];
}

- (IBAction)onTapWithdrawalsBtn:(id)sender {
    if (self.userZoneViewModel.isIdentification) {
        [self performSegueWithIdentifier:@"ShowWithdrawalViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"ShowRealInfoComfirmViewController" sender:self];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCell"];
    
    CouponsViewModel *viewModel = [self.couponsArr objectAtIndex:indexPath.row];
    [cell layoutCouponCellSubviewsByCouponsViewModel:viewModel];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.scrollView]) {
        [UIView animateWithDuration:.2 animations:^{
            self.walletInfoScrollView.transform = CGAffineTransformMakeScale(0.98, 0.98);
            self.couponView.transform = CGAffineTransformMakeScale(0.98, 0.98);
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollView isEqual:scrollView]) {
        if (0 == scrollView.contentOffset.x) {
            self.markView.transform = CGAffineTransformIdentity;
        } else {
            self.markView.transform = CGAffineTransformMakeTranslation(self.view.width / 2.0, 0);
        }
        
        [UIView animateWithDuration:.2 animations:^{
            self.walletInfoScrollView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.couponView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
        }];
    }
}

@end

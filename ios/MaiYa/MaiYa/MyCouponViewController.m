//
//  MyCouponViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/8.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyCouponViewController.h"
#import "CouponCell.h"

@interface MyCouponViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *couponsArr;
@end

@implementation MyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getuserCoupons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)getuserCoupons {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"couponsList" params:@{@"uid": uid, @"status": @"7"} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        self.couponsArr = [NSMutableArray new];
        for (NSDictionary *dic in resArr) {
            CouponsModel *model = [[CouponsModel alloc] initWithDic:dic];
            CouponsViewModel *viewModel = [[CouponsViewModel alloc] initWithCouponsModel:model];
            [self.couponsArr addObject:viewModel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCell"];
    
    CouponsViewModel *viewModel = [self.couponsArr objectAtIndex:indexPath.row];
    [cell layoutCouponCellSubviewsByCouponsViewModel:viewModel];
    cell.selectedIcon.hidden = YES;
    
    cell.isCanUse = YES;
    if (viewModel.type == CouponTypeOfFullCut) {
        if (self.orderPriceStr.integerValue < viewModel.moneyFullStr.integerValue) {
            cell.isCanUse = NO;
        }
    }
    
    CouponsModel *selectedCoupon = [UserConfigManager shareManager].createOrderViewModel.couponInfo;
    if (selectedCoupon && [selectedCoupon.cid isEqualToString:viewModel.couponsModel.cid]) {
        cell.selectedIcon.hidden = NO;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CouponCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.isCanUse) {
        if (cell.selectedIcon.hidden) {
            CouponsViewModel *viewModel = [self.couponsArr objectAtIndex:indexPath.row];
            [UserConfigManager shareManager].createOrderViewModel.couponInfo = viewModel.couponsModel;
            [UserConfigManager shareManager].createOrderViewModel.isUsingCoupon = YES;
            
            [tableView reloadData];
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            cell.selectedIcon.hidden = YES;
            [UserConfigManager shareManager].createOrderViewModel.isUsingCoupon = NO;
        }
    }
}

@end

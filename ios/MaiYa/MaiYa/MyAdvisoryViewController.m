//
//  MyAdvisoryViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyAdvisoryViewController.h"
#import "MyAdvisoryCell.h"
#import "AdvisoryDetailViewController.h"
#import "PayViewController.h"
#import "MyZoneViewController.h"

@interface MyAdvisoryViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *inTableView;
@property (weak, nonatomic) IBOutlet UITableView *finishTableView;

@property (strong, nonatomic) NSMutableArray *inOrdersArr;
@property (strong, nonatomic) NSMutableArray *finishedOrderArr;

@property (copy, nonatomic) NSString *selectedOrderId;
@property (copy, nonatomic) NSString *payMoneyStr;
@property (copy, nonatomic) NSString *selectedMasterId;
@end

@implementation MyAdvisoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.inOrdersArr = [NSMutableArray new];
    self.finishedOrderArr = [NSMutableArray new];
    
    [self getOrderListByType:@"1"];//进行中
    [self getOrderListByType:@"2"];//已完成
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}

- (BOOL)navigationShouldPopOnBackButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
    return YES;
}

#pragma mark -
- (void)reloadTableViews {
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    [self getOrderListByType:[NSString stringWithFormat:@"%zd", index + 1]];
}

- (void)tapCellBtnsByBtnTitle:(NSString *)title orderViewModel:(OrderViewModel *)orderViewModel{
    self.selectedOrderId = orderViewModel.orderIdStr;
    
    if ([title isEqualToString:@"取消订单"]) {
        [CustomTools alertShow:@"您确认取消订单吗？" content:@"一天内3次取消订单，当日将不能再平台预约！\n如果订单已经支付\n1.)资费全部退还（取消订单时间>1小时）\n2.)扣除资费20%违约金（取消订单时间<1小时）" cancelBtnTitle:@"再想想" okBtnTitle:@"确定" container:self];
    } else if ([title isEqualToString:@"付款"]) {
        self.payMoneyStr = orderViewModel.realPriceStr;
        [self performSegueWithIdentifier:@"ShowPayViewController" sender:self];
    } else if ([title isEqualToString:@"电话沟通"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", orderViewModel.telStr]]];
    } else if ([title isEqualToString:@"完成"]) {
        [self changeSelectedOrderStatusWithOrderId:self.selectedOrderId andStatusStr:@"orderStatus"];
    } else if ([title isEqualToString:@"评价"]) {
        self.selectedOrderId = orderViewModel.orderIdStr;
        [self performSegueWithIdentifier:@"ShowAdvisoryDetailViewController" sender:self];
    } else if ([title isEqualToString:@"再次预约"]) {
        self.selectedMasterId = orderViewModel.cidStr;
        [self performSegueWithIdentifier:@"ShowMasterZone" sender:self];
    } else {
        
    }
}

#pragma mark - networking
- (void)getOrderListByType:(NSString *)type {//type == 1 进行中； type == 2 已完成；
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderList" params:@{@"uid": uid, @"type": type} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            OrderModel *model = [[OrderModel alloc] initWithDic:dic];
            OrderViewModel *viewModel = [[OrderViewModel alloc] initWithOrderModel:model];
            
            if ([type isEqualToString:@"1"]) {
                [self.inOrdersArr addObject:viewModel];
            } else {
                [self.finishedOrderArr addObject:viewModel];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([type isEqualToString:@"1"]) {
                [self.inTableView reloadData];
            } else {
                [self.finishTableView reloadData];
            }
        });
    }];
}

- (void)changeSelectedOrderStatusWithOrderId:(NSString *)orderId andStatusStr:(NSString *)statusStr {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:statusStr params:@{@"uid": uid, @"orderid": orderId} success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableViews];
        });
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowAdvisoryDetailViewController"]) {
        AdvisoryDetailViewController *controller = segue.destinationViewController;
        controller.orderIdStr = self.selectedOrderId;
    } else if ([segue.identifier isEqualToString:@"ShowPayViewController"]) {
        PayViewController *vc = segue.destinationViewController;
        vc.orderIdStr = self.selectedOrderId;
        vc.moneyStr = self.payMoneyStr;
    } else if ([segue.identifier isEqualToString:@"ShowMasterZone"]) {
        MyZoneViewController *contrller = segue.destinationViewController;
        contrller.type = ZoneViewControllerTypeOfOther;
        contrller.cidStr = self.selectedMasterId;
    }
}

#pragma mark - IBAction
- (IBAction)onTapInBtn:(id)sender {
    self.markView.transform = CGAffineTransformIdentity;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)onTapFinishBtn:(id)sender {
    self.markView.transform = CGAffineTransformMakeTranslation(self.markView.width, 0);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.inTableView]) {
        return self.inOrdersArr.count;
    } else {
        return self.finishedOrderArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.inTableView]) {
        MyAdvisoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryInCell"];
        
        OrderViewModel *viewModel = [self.inOrdersArr objectAtIndex:indexPath.row];
        [cell layoutMyAdvisorySubviewsByOrderViewModel:viewModel];
        
        cell.tapBtnHandler = ^(NSString *titleStr) {
            [self tapCellBtnsByBtnTitle:titleStr orderViewModel:viewModel];
        };
        
        return  cell;
    } else {
        MyAdvisoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryFinishCell"];
        
        OrderViewModel *viewModel = [self.finishedOrderArr objectAtIndex:indexPath.row];
        [cell layoutMyAdvisorySubviewsByOrderViewModel:viewModel];
        
        cell.tapBtnHandler = ^(NSString *titleStr) {
            [self tapCellBtnsByBtnTitle:titleStr orderViewModel:viewModel];
        };
        
        return  cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderViewModel *viewModel;
    if ([tableView isEqual:self.inTableView]) {
        viewModel = [self.inOrdersArr objectAtIndex:indexPath.row];
    } else {
        viewModel = [self.finishedOrderArr objectAtIndex:indexPath.row];
    }
    
    self.selectedOrderId = viewModel.orderIdStr;
    
    [self performSegueWithIdentifier:@"ShowAdvisoryDetailViewController" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.inTableView]) {
        OrderViewModel *viewModel = [self.inOrdersArr objectAtIndex:indexPath.row];
        if ([viewModel.statusStr isEqualToString:@"等待付款"]) {
            return 200;
        }
    }
    
    return 170;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollView isEqual:scrollView]) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        if (0 == index) {
            self.markView.transform = CGAffineTransformIdentity;
        } else {
            self.markView.transform = CGAffineTransformMakeTranslation(self.markView.width, 0);
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self changeSelectedOrderStatusWithOrderId:self.selectedOrderId andStatusStr:@"orderCancel"];
    }
}

@end

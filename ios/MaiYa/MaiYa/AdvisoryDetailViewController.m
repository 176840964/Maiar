//
//  AdvisoryDetailViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailViewController.h"
#import "AdvisoryDetailNumCell.h"
#import "AdvisoryDetailTimeCell.h"
#import "AdvisoryDetailTypeCell.h"
#import "AdvisoryDetailMasterCell.h"
#import "AdvisoryDetailServiceCell.h"
#import "AdvisoryDetailCommentCell.h"
#import "AdvisoryDetailEndCell.h"
#import "AdvisoryDetailDateCell.h"
#import "AdvisoryDetailPayCell0.h"
#import "AdvisoryDetailPayCell1.h"
#import "OrderDetailModel.h"
#import "PayViewController.h"
#import "MyCouponViewController.h"

@interface AdvisoryDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) OrderDetailViewModel *orderDetailViewModel;
@property (copy, nonatomic) NSString *payMoneyStr;
@end

@implementation AdvisoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.orderIdStr.isValid) {
        [self getOrderDetailInfo];
    } else {
        [UserConfigManager shareManager].createOrderViewModel.couponInfo = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.orderIdStr.isValid) {
        [self getUserInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (OrderDetailViewModel *)orderDetailViewModel {
    if (nil == _orderDetailViewModel) {
        _orderDetailViewModel = [[OrderDetailViewModel alloc] initWithCreateOrderViewModel:[UserConfigManager shareManager].createOrderViewModel];
    } else {
        [_orderDetailViewModel layoutOrderDetailViewModelByCreateOrderViewModel:[UserConfigManager shareManager].createOrderViewModel];
    }
    
    return _orderDetailViewModel;
}

#pragma mark - networking
- (void)getOrderDetailInfo {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid
    uid = @"1";
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderInfo" params:@{@"uid": uid, @"orderid": self.orderIdStr} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        OrderDetailModel *model = [[OrderDetailModel alloc] initWithDic:resDic];
        self.orderDetailViewModel = [[OrderDetailViewModel alloc] initWithOrderDetailModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}

- (void)getUserInfo {
    NSString *cid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userInfo" params:@{@"cid": cid} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        [UserConfigManager shareManager].createOrderViewModel.userInfo = [[UserZoneModel alloc] initWithDic:resDic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)commitCommentWithContent:(NSString *)content andStarValue:(NSString *)starValue {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid
    uid = @"1";
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"comment" params:@{@"uid": uid, @"orderid": self.orderDetailViewModel.orderIdStr, @"star": starValue, @"content": content} success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

- (void)commitOrder {
    [[NetworkingManager shareManager] networkingWithPostMethodPath:@"order" postParams:[UserConfigManager shareManager].createOrderViewModel.paraDic success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        self.orderIdStr = [resDic objectForKey:@"orderid"];
        
        NSString *string = [UserConfigManager shareManager].createOrderViewModel.moneyStr;
        self.payMoneyStr = [NSString stringWithFormat:@"%.2f", string.doubleValue / 100];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([UserConfigManager shareManager].createOrderViewModel.isNeedThirdPay) {
                [self performSegueWithIdentifier:@"ShowPayViewController" sender:self];
            } else {
                [self performSegueWithIdentifier:@"ShowAdvisoryViewController" sender:self];
            }
            [[UserConfigManager shareManager].createOrderViewModel clear];
        });
    }];
}

#pragma mark - IBAction

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPayViewController"]) {
        PayViewController *vc = segue.destinationViewController;
        vc.orderIdStr = self.orderIdStr;
        vc.moneyStr = self.payMoneyStr;
    } else if ([segue.identifier isEqualToString:@"ShowMyCouponViewController"]) {
        MyCouponViewController *vc = segue.destinationViewController;
        vc.orderPriceStr = [UserConfigManager shareManager].createOrderViewModel.originalMoneyAllStr;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderDetailViewModel.identifiersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = [self.orderDetailViewModel.identifiersArr objectAtIndex:indexPath.row];
    
    if ([indentifier isEqualToString:@"AdvisoryDetailNumCell"]) {
        AdvisoryDetailNumCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell.numLab.text = self.orderDetailViewModel.orderIdStr;
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTypeCell"]) {
        AdvisoryDetailTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell.typeLab.text = self.orderDetailViewModel.problemStr;
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailMasterCell"]) {
        AdvisoryDetailMasterCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        [cell.headerImageView setImageWithURL:self.orderDetailViewModel.userInfoViewModel.headUrl placeholderImage:[UIImage imageNamed:DefaultUserHeaderImage]];
        cell.sexImageView.image = self.orderDetailViewModel.userInfoViewModel.sexImage;
        cell.nameLab.attributedText = self.orderDetailViewModel.userInfoViewModel.nickAndWorkAgeAttributedStr;
        cell.scoreLab.text = self.orderDetailViewModel.userInfoViewModel.commentAllStr;
        cell.countLab.text = self.orderDetailViewModel.userInfoViewModel.commentNumStr;
        cell.priceLab.text = self.orderDetailViewModel.userInfoViewModel.moneyPerHourStr;
        cell.locationLab.text = self.orderDetailViewModel.userInfoViewModel.distanceStr;
        for (NSInteger index = 0; index < cell.catsArr.count; ++index) {
            UILabel *lab = [cell.catsArr objectAtIndex:index];
            if (index >= self.orderDetailViewModel.userInfoViewModel.workTypesArr.count) {
                lab.hidden = YES;
            } else {
                NSDictionary *dic = [self.orderDetailViewModel.userInfoViewModel.workTypesArr objectAtIndex:index];
                lab.hidden = NO;
                lab.text = [dic objectForKey:@"text"];
                lab.backgroundColor = [dic objectForKey:@"bgColor"];
                lab.font = [dic objectForKey:@"font"];
            }
        }
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailUserCell"]) {
        AdvisoryDetailUserCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        [cell.headerImageView setImageWithURL:self.orderDetailViewModel.userInfoViewModel.headUrl placeholderImage:[UIImage imageNamed:DefaultUserHeaderImage]];
        cell.sexImageView.image = self.orderDetailViewModel.userInfoViewModel.sexImage;
        cell.nameLab.text = self.orderDetailViewModel.userInfoViewModel.nickStr;
        cell.locationLab.text = self.orderDetailViewModel.userInfoViewModel.distanceStr;
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTimeCell"]) {
        AdvisoryDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        [cell layoutAdvisoryDetailTimeCellSubviewsByOrderDateModelArr:self.orderDetailViewModel.consultingTimeArr];
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailServiceCell"]) {
        AdvisoryDetailServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell.serviceTypeLab.text = self.orderDetailViewModel.serviceModeStr;
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailCommentCell"]) {
        AdvisoryDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        __weak typeof(cell) weakCell = cell;
        cell.tapCommitCommentHandler = ^() {
            [self commitCommentWithContent:weakCell.textView.text andStarValue:weakCell.selectedStarCountStr];
        };
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailEndCell"]) {
        AdvisoryDetailEndCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell.commentLab.text = self.orderDetailViewModel.commentViewModel.contentStr;
        for (NSInteger index = 0; index < cell.straImagesArr.count; index ++) {
            UIImageView *imageView = [cell.straImagesArr objectAtIndex:index];
            if (index < self.orderDetailViewModel.commentViewModel.starCountStr.integerValue) {
                imageView.image = [UIImage imageNamed:@"bigStar1"];
            } else {
                imageView.image = [UIImage imageNamed:@"bigStar0"];
            }
        }
        
        return cell;
                 
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell0"]) {
        AdvisoryDetailPayCell0 *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell.balanceLab.text = self.orderDetailViewModel.balanceStr;
        cell.totalPriceLab.text = self.orderDetailViewModel.moneyAllStr;
        cell.useBalanceSwitch.on = [UserConfigManager shareManager].createOrderViewModel.isUsingBalance;
        
        BOOL isHasConpons = [UserConfigManager shareManager].createOrderViewModel.isHasCoupons;
        CouponsModel *couponInfo = [UserConfigManager shareManager].createOrderViewModel.couponInfo;
        cell.useCouponStatusLab.text = (nil != couponInfo) ? couponInfo.name : (isHasConpons ? @"未使用" : @"无可使用");
        
        cell.tapCommitBtnHandle = ^() {
            [self commitOrder];
        };
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell1"]) {
        AdvisoryDetailPayCell1 *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        cell.totalPriceLab.text = self.orderDetailViewModel.nonPayMoneyAllStr;
        cell.couponPriceLab.text = self.orderDetailViewModel.nonPayMoneyCouponStr;
        cell.balancePriceLab.text = self.orderDetailViewModel.nonPayMoneyBalanceStr;
        cell.actualPriceLab.attributedText = self.orderDetailViewModel.nonPayMoneyStr;
        cell.dateLab.text = self.orderDetailViewModel.timeStr;
        
        cell.tapCommitBtnHandle = ^() {
            self.payMoneyStr = self.orderDetailViewModel.moneyStr;
            [self performSegueWithIdentifier:@"ShowPayViewController" sender:self];
        };
        
        return cell;
        
    } else {
        
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    NSString *indentifier = [self.orderDetailViewModel.identifiersArr objectAtIndex:indexPath.row];
    
    if ([indentifier isEqualToString:@"AdvisoryDetailNumCell"]) {
        height = 58;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTypeCell"]) {
        height = 41;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailMasterCell"]) {
        height = 104;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailUserCell"]) {
        height = 104;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTimeCell"]) {
        height = 33 + 70 * self.orderDetailViewModel.consultingTimeArr.count;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailServiceCell"]) {
        height = 80;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailCommentCell"]) {
        height = 340;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailEndCell"]) {
        height = 172;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell0"]) {
        height = 132;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell1"]) {
        height = 315;
    } else {
        height = 0;
    }
    
    return height;
}

@end

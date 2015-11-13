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

@interface AdvisoryDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) OrderDetailViewModel *orderDetailViewModel;
@end

@implementation AdvisoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.orderIdStr.isValid) {
        [self getOrderDetailInfo];
    } else {
        [self getUserInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)getOrderingDetail {
    self.orderDetailViewModel = [[OrderDetailViewModel alloc] initWithCreateOrderViewModel:[UserConfigManager shareManager].createOrderViewModel];
    
    [self.tableView reloadData];
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
            [self getOrderingDetail];
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

#pragma mark - IBAction
- (IBAction)onTapPayBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowPayViewController" sender:self];
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
        
        return cell;
        
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell1"]) {
        AdvisoryDetailPayCell1 *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
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

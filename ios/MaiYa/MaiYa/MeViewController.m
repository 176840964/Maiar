//
//  MeViewController.m
//  MaiYa
//
//  Created by zxl on 15/11/26.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "MeHeaderView.h"
#import "MyZoneViewController.h"

@interface MeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *group1DataArr;
@property (strong, nonatomic) NSMutableArray *group2DataArr;
@property (strong, nonatomic) MeHeaderView *headerView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    
    self.headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 219)];
    self.headerView.type = [UserConfigManager shareManager].isLogin ? MeHeaderTypeOfLogin : MeHeaderTypeOfLogout;
    self.headerView.tapUserHeadPortraitHandler = ^() {
        if (MeHeaderTypeOfLogout == self.headerView.type) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationOfShowingLogin" object:nil];
        } else {
            [weakSelf performSegueWithIdentifier:@"ShowUserInfoViewController" sender:weakSelf];
        }
    };
    
    self.tableView.tableHeaderView = self.headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    if ([uid isKindOfClass:[NSString class]] && 0 != uid.length) {
        self.headerView.type = MeHeaderTypeOfLogin;
    } else {
        self.headerView.type = MeHeaderTypeOfLogout;
    }
    
    self.group1DataArr = [NSMutableArray new];
    
    NSDictionary *dic = nil;
    if ([UserConfigManager shareManager].isLogin) {
        dic = @{@"title": @"我的空间", @"img": @"myZone", @"segue": @"ShowMyZoneViewController"};
        [self.group1DataArr addObject:dic];
    }
    dic = @{@"title": @"我的收藏", @"img": @"myCollection", @"segue": @"ShowMyCollectionViewController"};
    [self.group1DataArr addObject:dic];
    dic = @{@"title": @"我的钱包", @"img": @"myWallet", @"segue": @"ShowMyWalletViewController"};
    [self.group1DataArr addObject:dic];
    
    self.group2DataArr = [NSMutableArray new];
    dic = @{@"title": @"消息", @"img": @"myMessage", @"segue": @"ShowNoticeViewController"};
    [self.group2DataArr addObject:dic];
    dic = @{@"title": @"设置", @"img": @"mySetting", @"segue": @"ShowSettingViewController"};
    [self.group2DataArr addObject:dic];
    
    [self.tableView reloadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMyZoneViewController"]) {
        MyZoneViewController *controller = segue.destinationViewController;
        controller.type = ZoneViewControllerTypeOfMine;
        NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
        controller.cidStr = uid;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0 == section ? self.group1DataArr.count : self.group2DataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell"];
    NSDictionary *dic = 0 == indexPath.section ? [self.group1DataArr objectAtIndex:indexPath.row] : [self.group2DataArr objectAtIndex:indexPath.row];
    
    [cell layoutSubViewByDic:dic];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = 0 == indexPath.section ? [self.group1DataArr objectAtIndex:indexPath.row] : [self.group2DataArr objectAtIndex:indexPath.row];
    
    NSString *segueIdentifier = [dic objectForKey:@"segue"];
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

@end

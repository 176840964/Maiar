//
//  MeTableViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MeTableViewController.h"
#import "MeHeaderView.h"
#import "MyZoneViewController.h"

@interface MeTableViewController ()
@property (strong, nonatomic) MeHeaderView *headerView;
@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    if ([uid isKindOfClass:[NSString class]] && 0 != uid.length) {
        self.headerView.type = MeHeaderTypeOfLogin;
    } else {
        self.headerView.type = MeHeaderTypeOfLogout;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMyZoneViewController"]) {
        MyZoneViewController *controller = segue.destinationViewController;
        controller.type = ZoneViewControllerTypeOfMine;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section && 0 == indexPath.row) {
        [self performSegueWithIdentifier:@"ShowMyZoneViewController" sender:self];
    }
}

@end

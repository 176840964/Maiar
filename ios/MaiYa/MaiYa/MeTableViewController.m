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

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MeHeaderView* headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 219)];
    headerView.type = MeHeaderTypeOfLogout;
    headerView.tapUserHeadPortraitHandler = ^() {
        if (MeHeaderTypeOfLogout == headerView.type) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationOfShowingLogin" object:nil];
        } else {
            [self performSegueWithIdentifier:@"ShowUserInfoViewController" sender:self];
        }
    };
    
    self.tableView.tableHeaderView = headerView;
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

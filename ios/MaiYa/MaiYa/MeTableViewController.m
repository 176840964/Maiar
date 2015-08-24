//
//  MeTableViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MeTableViewController.h"
#import "MeHeaderView.h"

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MeHeaderView* headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 219)];
    headerView.tapUserHeadPortraitHandler = ^() {
        [self performSegueWithIdentifier:@"ShowUserInfoViewController" sender:self];
    };
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

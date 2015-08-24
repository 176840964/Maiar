//
//  UserInfoViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"

@interface UserInfoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation UserInfoViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"UserInfoCell%zd", indexPath.row]];
    
    switch (indexPath.row) {
        case 0:
            cell.imgView.image = [UIImage imageNamed:@"login_bg"];
            break;
        case 1:
            cell.lab.text = @"zhangran";
            break;
        case 2:
            cell.lab.text = @"13911016821";
            break;
        default:
            cell.lab.text = @"男";
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

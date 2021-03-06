//
//  UserSexViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserSexViewController.h"
#import "UserSexCell.h"

@interface UserSexViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation UserSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = [self.sexStr isEqualToString:@"男"] ? 0 : 1;
}

#pragma mark - 
- (void)editSex {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"editUserInfo" params:@{@"uid": uid, @"gender": @(self.index + 1)} success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserSexCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"UserSexCell%zd", indexPath.row]];
    
    if (self.index == indexPath.row) {
        cell.imgView.hidden = NO;
    } else {
        cell.imgView.hidden = YES;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.index = indexPath.row;
    [self editSex];
}

@end

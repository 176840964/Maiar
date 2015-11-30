//
//  WithdrawalsDetailsViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WithdrawalsDetailsViewController.h"
#import "DetailCell.h"

@interface WithdrawalsDetailsViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation WithdrawalsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = [NSMutableArray new];
    [self getUserWithdrawalsDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NetWorking
- (void)getUserWithdrawalsDetails {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userOrder" params:@{@"uid": uid} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            AccountDetailsModel *model = [[AccountDetailsModel alloc] initWithDic:dic];
            AccountDetailsViewModel *viewModel = [[AccountDetailsViewModel alloc] initWithAccountDetailsModel:model];
            [self.dataArr addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    
    AccountDetailsViewModel *viewModel = [self.dataArr objectAtIndex:indexPath.row];
    [cell layoutDetailCellSubviewsByAccountDetailsViewModel:viewModel];
    
    return cell;
}

@end

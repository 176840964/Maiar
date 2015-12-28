//
//  WithdrawalsDetailsViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WithdrawalsDetailsViewController.h"
#import "DetailCell.h"

@interface WithdrawalsDetailsViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (weak, nonatomic) IBOutlet CustomTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation WithdrawalsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.customDelegate = self;
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
    
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
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userOrder" params:@{@"uid": uid, @"start": self.tableView.startOffsetStr} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        
        NSMutableArray *dataArr = [NSMutableArray new];
        
        for (NSDictionary *dic in resArr) {
            AccountDetailsModel *model = [[AccountDetailsModel alloc] initWithDic:dic];
            AccountDetailsViewModel *viewModel = [[AccountDetailsViewModel alloc] initWithAccountDetailsModel:model];
            [dataArr addObject:viewModel];
        }
        
        if (self.tableView.type == CustomTableViewUpdateTypeReloadMore) {
            [self.dataArr addObjectsFromArray:dataArr];
            [self.tableView finishReloadMoreDataWithIsEnd:(0 == dataArr.count)];
        } else {
            self.dataArr = dataArr;
            [self.tableView finishRefreshData];
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

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = @"0";
    [self getUserWithdrawalsDetails];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = [NSString stringWithFormat:@"%zd", self.dataArr.count];
    [self getUserWithdrawalsDetails];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView.refreshView refreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView.refreshView refreshScrollViewDidScroll:scrollView];
    [self.tableView.reloadMoreView scrollViewDidScroll:scrollView];
}

@end

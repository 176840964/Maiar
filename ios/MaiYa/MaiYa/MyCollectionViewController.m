//
//  MyCollectionViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MasterCell.h"

@interface MyCollectionViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (nonatomic, weak) IBOutlet CustomTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.customDelegate = self;
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
    
    self.dataArr = [NSMutableArray new];
    
    [self getCollectList];
}

#pragma mark - 
- (void)getCollectList {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"collectList" params:@{@"uid": uid, @"start": self.tableView.startOffsetStr} success:^(id responseObject) {
        NSArray *resDic = [responseObject objectForKey:@"res"];
        
        NSMutableArray *dataArr = [NSMutableArray new];
        
        for (NSDictionary *dic in resDic) {
            UserZoneModel *model = [[UserZoneModel alloc] initWithDic:dic];
            UserZoneViewModel *viewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    UserZoneViewModel *viewModel = [self.dataArr objectAtIndex:indexPath.row];
    [cell layoutMasterCellSubviewsByUserZoneViewModel:viewModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = @"0";
    [self getCollectList];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = [NSString stringWithFormat:@"%zd", self.dataArr.count];
    [self getCollectList];
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

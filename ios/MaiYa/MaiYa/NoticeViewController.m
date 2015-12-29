//
//  NoticeViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeCell.h"

@interface NoticeViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (nonatomic, weak) IBOutlet CustomTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NoticeCell *commonCell;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.customDelegate = self;
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
    
    [self.tableView registerClass:[NoticeCell class] forCellReuseIdentifier:@"NoticeCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.commonCell = [self.tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
    
    self.dataArr = [NSMutableArray new];
    [self getMessageList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Networking
- (void)getMessageList {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"message" params:@{@"uid": uid, @"start": self.tableView.startOffsetStr} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        
        NSMutableArray *dataArr = [NSMutableArray new];
        
        for (NSDictionary *dic in resArr) {
            MessageModel *model = [[MessageModel alloc] initWithDic:dic];
            MessageViewModel *viewModel = [[MessageViewModel alloc] initWithMessageModel:model];
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
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
    
    MessageViewModel *viewModel = [self.dataArr objectAtIndex:indexPath.row];
    [cell layoutNoticCellSubviewsByMessageViewModel:viewModel];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageViewModel *viewModel = [self.dataArr objectAtIndex:indexPath.row];
    [self.commonCell layoutNoticCellSubviewsByMessageViewModel:viewModel];
    
    NoticeCell *cell = self.commonCell;
    cell.contentLab.text = viewModel.contentStr;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0, 0, self.tableView.width, cell.height);
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = @"0";
    [self getMessageList];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = [NSString stringWithFormat:@"%zd", self.dataArr.count];
    [self getMessageList];
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

//
//  CommentViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "CommentHeaderView.h"

@interface CommentViewController () <CustomTableViewViewDelegate>
@property (weak, nonatomic) IBOutlet CustomTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dateArr;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评论";
    
    self.tableView.customDelegate = self;
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
    
    self.dateArr = [NSMutableArray new];
    
    CommentHeaderView *headerView = [[CommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 45)];
    [headerView layoutCommentHeaderViewSubviewsCountString:self.countStr andAllValueString:self.allValueStr];
    self.tableView.tableHeaderView = headerView;
    
    [self getCommentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)getCommentList {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"commentList" params:@{@"uid": self.masterIdStr, @"start": self.tableView.startOffsetStr} success:^(id responseObject) {
        NSArray *listArr = [[responseObject objectForKey:@"res"] objectForKey:@"list"];
        
        NSMutableArray *dateArr = [NSMutableArray new];
        
        for (NSDictionary *dic in listArr) {
            CommentModel *model = [[CommentModel alloc] initWithDic:dic];
            CommentViewModel *viewModel = [[CommentViewModel alloc] initWithCommentModel:model];
            [dateArr addObject:viewModel];
        }
        
        if (self.tableView.type == CustomTableViewUpdateTypeReloadMore) {
            [self.dateArr addObjectsFromArray:dateArr];
            [self.tableView finishReloadMoreDataWithIsEnd:(0 == dateArr.count)];
        } else {
            self.dateArr = dateArr;
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
    return self.dateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    CommentViewModel *viewModel = [self.dateArr objectAtIndex:indexPath.row];
    [cell layoutCommentCellSubviewsByCommentViewModel:viewModel];
    
    return cell;
}

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = @"0";
    [self getCommentList];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = [NSString stringWithFormat:@"%zd", self.dateArr.count];
    [self getCommentList];
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

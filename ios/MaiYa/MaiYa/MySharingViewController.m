//
//  MySharingViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MySharingViewController.h"
#import "MySharingCell.h"

@interface MySharingViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (weak ,nonatomic) IBOutlet CustomTableView *tableView;
@property (strong, nonatomic) NSMutableArray *articleArr;
@end

@implementation MySharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.customDelegate = self;
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
    
    self.articleArr = [NSMutableArray new];
    
    UINib *cellNib = [UINib nibWithNibName:@"MySharingCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MySharingCell"];
    
    [self getMyArticlesList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)getMyArticlesList {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"articleTypeList" params:@{@"uid": self.masterIdStr, @"start": self.tableView.startOffsetStr} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        NSMutableArray *articleArr = [NSMutableArray new];
        for (NSDictionary *dic in resArr) {
            ArticleModel *model = [[ArticleModel alloc] initWithDic:dic];
            ArticleViewModel *viewModel = [[ArticleViewModel alloc] initWithArticleModel:model];
            [articleArr addObject:viewModel];
        }
        
        if (self.tableView.type == CustomTableViewUpdateTypeReloadMore) {
            [self.articleArr addObjectsFromArray:articleArr];
            [self.tableView finishReloadMoreDataWithIsEnd:(0 == articleArr.count)];
        } else {
            self.articleArr = articleArr;
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
    return self.articleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MySharingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySharingCell"];
    
    ArticleViewModel* viewModel = [self.articleArr objectAtIndex:indexPath.row];
    [cell layoutMySharingCellSubviewsByArticleViewModel:viewModel];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = @"0";
    [self getMyArticlesList];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    self.tableView.startOffsetStr = [NSString stringWithFormat:@"%zd", self.articleArr.count];
    [self getMyArticlesList];
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

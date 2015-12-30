//
//  MySharingViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MySharingViewController.h"
#import "MySharingCell.h"
#import "PlazaDetailViewController.h"

@interface MySharingViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (weak ,nonatomic) IBOutlet CustomTableView *tableView;
@property (strong, nonatomic) NSMutableArray *articleArr;

@property (strong, nonatomic) ArticleViewModel *selectedArticleViewModel;
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

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPlazaDetail"]) {
        
        PlazaDetailViewController *controller = segue.destinationViewController;
        controller.type = PlazaDetailParaTypeOfArticle;
        controller.catIndexStr = self.selectedArticleViewModel.typeStr;
        controller.articleStr = self.selectedArticleViewModel.aidStr;
        controller.title = self.selectedArticleViewModel.titleStr;
        controller.shareUrlStr = self.selectedArticleViewModel.shareUrlStr;
        controller.articleOwnerIdStr = self.selectedArticleViewModel.uidStr;
    }
}

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedArticleViewModel = [self.articleArr objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
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

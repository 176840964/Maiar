//
//  SearchViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/6.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "SearchViewController.h"
#import "MasterCell.h"
#import "MyZoneViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource, RefreshDropdownViewDelegate, ReloadMoreDropupViewDelegate>
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (copy, nonatomic) NSString *selectedMasterId;

@property (assign, nonatomic) BOOL isRefreshLoading;
@property (assign, nonatomic) CustomTableViewUpdateType type;
@property (weak, nonatomic) id<CustomTableViewViewDelegate> customDelegate;
@property (strong, nonatomic) RefreshDropdownView *refreshView;
@property (strong, nonatomic) ReloadMoreDropupView* reloadMoreView;
@property (copy, nonatomic) NSString *start;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.start = @"0";
    
    self.searchResults = [NSMutableArray new];
    
    self.searchDisplayController.searchBar.tintColor = [UIColor whiteColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.searchDisplayController.searchResultsTableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
    self.searchDisplayController.searchResultsTableView.rowHeight = 77;
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor clearColor];
    
    [self.searchDisplayController.searchResultsTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (nil == _refreshView) {
        _refreshView = [[RefreshDropdownView alloc] initWithFrame:CGRectMake(0, -44, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
        _refreshView.backgroundColor = [UIColor clearColor];
        _refreshView.delegate = self;
        [self.searchDisplayController.searchResultsTableView addSubview:_refreshView];
    }
    
    if (nil == _reloadMoreView) {
        _reloadMoreView = [[ReloadMoreDropupView alloc] initWithFrame:CGRectMake(0, self.searchDisplayController.searchResultsTableView.contentSize.height + (self.searchDisplayController.searchResultsTableView.bounds.size.height - MIN(self.searchDisplayController.searchResultsTableView.bounds.size.height, self.searchDisplayController.searchResultsTableView.contentSize.height)), CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
        _reloadMoreView.backgroundColor = [UIColor clearColor];
        _reloadMoreView.delegate = self;
        [self.searchDisplayController.searchResultsTableView addSubview:_reloadMoreView];
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - 
- (void)finishRefreshData {
    self.type = CustomTableViewUpdateTypeNone;
    self.isRefreshLoading = NO;
    [self.refreshView refreshScrollViewDataSourceDidFinishedLoading:self.searchDisplayController.searchResultsTableView];
    self.reloadMoreView.statue = ReloadMoreDropupDroping;
}

- (void)finishReloadMoreDataWithIsEnd:(BOOL)isEnd {
    self.type = CustomTableViewUpdateTypeNone;
    if (isEnd) {
        self.reloadMoreView.statue = ReloadMoreDropupEnd;
    } else {
        self.reloadMoreView.statue = ReloadMoreDropupDroping;
    }
    [self.reloadMoreView didFinishedReloadWithScrollView:self.searchDisplayController.searchResultsTableView];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        self.reloadMoreView.frame = CGRectMake(0, self.searchDisplayController.searchResultsTableView.contentSize.height + (self.searchDisplayController.searchResultsTableView.bounds.size.height - MIN(self.searchDisplayController.searchResultsTableView.bounds.size.height, self.searchDisplayController.searchResultsTableView.contentSize.height)), CGRectGetWidth([UIScreen mainScreen].bounds), 44);
    }
}

#pragma mark - NetWorking
- (void)getUserListByKeyWordStr:(NSString *)keyWordStr {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if ([UserConfigManager shareManager].isLogin) {
        NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
        [dic setObject:uid forKey:@"uid"];
    } else {
        NSString *lon = [UserConfigManager shareManager].lonStr;
        NSString *lat = [UserConfigManager shareManager].latStr;
        
        [dic setObject:lon forKey:@"longitude"];
        [dic setObject:lat forKey:@"latitude"];
    }
    
    if (keyWordStr.isValid) {
        [dic setObject:keyWordStr forKey:@"fuzzy"];
    }
    
    [dic setObject:self.start forKey:@"start"];
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userList" params:dic success:^(id responseObject) {
        NSMutableArray *searchResults = [NSMutableArray new];
        
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            UserZoneModel *model = [[UserZoneModel alloc] initWithDic:dic];
            UserZoneViewModel *viewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
            [searchResults addObject:viewModel];
        }
        
        UITableView *tableView = self.searchDisplayController.searchResultsTableView;
        
        if (self.type == CustomTableViewUpdateTypeReloadMore) {
            [self.searchResults addObjectsFromArray:searchResults];
            [self finishReloadMoreDataWithIsEnd:(0 == searchResults.count)];
        } else {
            self.searchResults = searchResults;
            [self finishRefreshData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (0 == self.searchResults.count) {
                for( UIView *subview in tableView.subviews ) {
                    if( [subview class] == [UILabel class] ) {
                        UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                        lbl.text = @"没有结果";
                    }
                }
            } else {
                [self.searchDisplayController.searchResultsTableView reloadData];
            }
        });
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMasterZone"]) {
        MyZoneViewController *contrller = segue.destinationViewController;
        contrller.type = ZoneViewControllerTypeOfOther;
        contrller.cidStr = self.selectedMasterId;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    
    UserZoneViewModel *viewModel = [self.searchResults objectAtIndex:indexPath.row];
    [cell layoutMasterCellSubviewsByUserZoneViewModel:viewModel];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserZoneViewModel *viewModel = [self.searchResults objectAtIndex:indexPath.row];
    self.selectedMasterId = viewModel.uidStr;
    
    [self performSegueWithIdentifier:@"ShowMasterZone" sender:self];
}


#pragma mark - UISearchDisplayDelegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self getUserListByKeyWordStr:searchString];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    [searchBar setShowsCancelButton:YES animated:YES];
    for(UIView *subView in searchBar.subviews){
        if([subView isKindOfClass:UIButton.class]){
            [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshView refreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshView refreshScrollViewDidScroll:scrollView];
    [self.reloadMoreView scrollViewDidScroll:scrollView];
}

#pragma mark - RefreshDropdownViewDelegate
- (void)refreshDropdownViewDidTriggerRefresh:(RefreshDropdownView*)refreshDropdownView {
    self.type = CustomTableViewUpdateTypeRefresh;
    self.isRefreshLoading = YES;
    
    self.start = @"0";
    [self getUserListByKeyWordStr:self.searchDisplayController.searchBar.text];
}

- (BOOL)refreshDropdownViewDataSourceIsLoading:(RefreshDropdownView*)refreshDropdownView {
    return self.isRefreshLoading;
}

#pragma mark - ReloadMoreDropupViewDelegate
- (void)reloadMoreDropupViewWillReloadData:(ReloadMoreDropupView *)reloadMoreDropupView {
    self.type = CustomTableViewUpdateTypeReloadMore;
    
    self.start = [NSString stringWithFormat:@"%zd", self.searchResults.count];
    [self getUserListByKeyWordStr:self.searchDisplayController.searchBar.text];
}

@end

//
//  PlazaRootViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaRootViewController.h"
#import "PlazaWordCell.h"
#import "PlazaCell.h"
#import "PlazaHeaderView.h"
#import "SquareModel.h"
#import "PlazaCategoryViewController.h"
#import "PlazaDetailViewController.h"

@interface PlazaRootViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (weak, nonatomic) IBOutlet CustomTableView *tableView;
@property (strong, nonatomic) PlazaWordCell *commonCell;
@property (strong, nonatomic) PlazaHeaderView *headerView;
@property (strong, nonatomic) NSTimer *headerViewAutoScrollingTime;
@property (strong, nonatomic) SquareViewModel *squareViewModel;

@property (assign, nonatomic) PlazaDetailParaType showDetailType;
@property (copy, nonatomic) NSString *selectedCatStr;
@property (copy, nonatomic) NSString *selectedIdStr;
@property (strong, nonatomic) NSURL *selectedHeaderUrl;
@property (copy, nonatomic) NSString *showDetailTitleStr;
@property (copy, nonatomic) NSString *shareDetailUrlStr;
@end

@implementation PlazaRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerView = [[PlazaHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) * 250.0 / 750)];
    self.tableView.tableHeaderView = self.headerView;
    
    __weak typeof(self) weakSelf = self;
    self.headerView.tapHeaderViewHandle = ^(NSURL *url, NSString *titleStr) {
        weakSelf.showDetailType = PlazaDetailParaTypeOfUrl;
        weakSelf.selectedHeaderUrl = url;
        weakSelf.showDetailTitleStr = titleStr;
        weakSelf.shareDetailUrlStr = url.absoluteString;
        [weakSelf performSegueWithIdentifier:@"ShowPlazaDetail" sender:weakSelf];
    };
    
    [self.tableView registerClass:[PlazaWordCell class] forCellReuseIdentifier:@"PlazaWordCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.commonCell = [self.tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
    
    self.tableView.customDelegate = self;
    
    [self getSquareData];
    
    self.headerView.scrollView.delegate = self;
    [self headerViewAddAutoScrollingTimer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:NO];
}

#pragma mark -
- (void)getSquareData {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"square" params:nil success:^(id responseObject) {
        
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        SquareModel *model = [[SquareModel alloc] initWithDic:resDic];
        self.squareViewModel = [[SquareViewModel alloc] initWithSquareModel:model];
        
        if (self.tableView.type != CustomTableViewUpdateTypeReloadMore) {
            [self.tableView finishRefreshData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutSubviews];
        });
    }];
}

- (void)layoutSubviews {
    [self.tableView reloadData];
    [self.headerView layoutPlazeHeaderViewSubviewsByArr:self.squareViewModel.focusArr];
}

- (void)headerViewAddAutoScrollingTimer {
    self.headerViewAutoScrollingTime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScrollingHeaderViewToNext) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.headerViewAutoScrollingTime forMode:NSRunLoopCommonModes];
}

- (void)autoScrollingHeaderViewToNext {
    NSInteger page = self.headerView.pageControl.currentPage;
    if (page == self.squareViewModel.focusArr.count - 1) {
        page = 0;
    } else {
        page++;
    }
    
    CGFloat x = page * CGRectGetWidth(self.headerView.frame);
    [self.headerView.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)headerViewScrollViewRemoveTimer {
    [self.headerViewAutoScrollingTime invalidate];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPlazaDetail"]) {
        PlazaDetailViewController *viewController = segue.destinationViewController;
        viewController.type = self.showDetailType;
        viewController.catIndexStr = self.selectedCatStr;
        viewController.articleStr = self.selectedIdStr;
        viewController.url = self.selectedHeaderUrl;
        viewController.title = self.showDetailTitleStr;
        viewController.shareUrlStr = self.shareDetailUrlStr;
    } else if ([segue.identifier isEqualToString:@"ShowPlazaCategory"]) {
        PlazaCategoryViewController *viewController = segue.destinationViewController;
        viewController.catIndexStr = self.selectedCatStr;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        PlazaWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
        
        cell.textLab.text = self.squareViewModel.sentenceViewModel.contentStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        return cell;
    } else {
        ArticleDirectoryViewModel *viewModel = nil;
        switch (indexPath.row) {
            case 1:
                viewModel = self.squareViewModel.astrologyViewModel;
                break;
            case 2:
                viewModel = self.squareViewModel.tarlowViewModel;
                break;
                
            default:
                viewModel = self.squareViewModel.zhouyiViewModel;
                break;
        }
        
        PlazaCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"PlazaCell%zd", indexPath.row]];
        cell.tapBtnHandler = ^(NSString *catStr, ArticleIndexViewModel *indexViewModel) {
            self.selectedCatStr = catStr;
            self.selectedIdStr = indexViewModel.aidStr;
            self.showDetailType = PlazaDetailParaTypeOfArticle;
            self.showDetailTitleStr = indexViewModel.titleStr;
            self.shareDetailUrlStr = indexViewModel.shareUrlStr;
            [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
        };
        
        cell.tapCategoryBtnHandle = ^(NSString *str) {
            self.selectedCatStr = str;
            [self performSegueWithIdentifier:@"ShowPlazaCategory" sender:self];
        };
        
        [cell layoutPlazaCellSubviewsByAritcleDirectoryViewModel:viewModel];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        self.selectedCatStr = @"30";
        [self performSegueWithIdentifier:@"ShowPlazaCategory" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        PlazaWordCell *cell = self.commonCell;
        cell.textLab.text = self.squareViewModel.sentenceViewModel.contentStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.bounds = CGRectMake(0, 0, self.tableView.width, cell.height);
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        return height;
    } else {
        return 112;
    }
}

#pragma mark - CustomCollectionViewDelegate
- (void)customTableViewRefresh:(CustomTableView *)customTableView {
    [self getSquareData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.headerView.scrollView]) {
        [self headerViewScrollViewRemoveTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.headerView.scrollView isEqual:scrollView]) {
        [self headerViewAddAutoScrollingTimer];
    } else {
        [self.tableView.refreshView refreshScrollViewDidEndDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.headerView.scrollView isEqual:scrollView]) {
        CGFloat width = CGRectGetWidth(scrollView.frame);
        CGFloat offsetX = scrollView.contentOffset.x;
        
        NSInteger page = (offsetX + width / 2) / width;
        self.headerView.pageControl.currentPage = page;
    } else {
        [self.tableView.refreshView refreshScrollViewDidScroll:scrollView];
    }
}

@end

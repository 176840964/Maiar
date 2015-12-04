//
//  PlazaCategoryViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaCategoryViewController.h"
#import "ArticleCatModel.h"
#import "ArticleModel.h"
#import "ArticleCell.h"
#import "PlazaWordCell.h"
#import "PlazaDetailViewController.h"

typedef NS_ENUM(NSInteger, ContentTableViewType){
    ContentTableViewTypeOfDeselected = 0,
    ContentTableViewTypeOfCanSelcte,
};

@interface PlazaCategoryViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *catScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) UIView *markView;
@property (strong, nonatomic) NSArray *catsArr;
@property (strong, nonatomic) NSArray *contentsArr;
@property (strong, nonatomic) NSDictionary *dataDic;

@property (strong, nonatomic) CustomTableView *curTableView;
@property (strong, nonatomic) NSMutableArray *curDataArr;
@property (assign, nonatomic) NSInteger curOffsetIndex;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) PlazaWordCell *wordCell;
@end

@implementation PlazaCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.markView = [[UIView alloc] init];
    self.markView.hidden = YES;
    self.markView.backgroundColor = [UIColor colorWithHexString:@"#ee6bfe"];
    [self.catScrollView addSubview:self.markView];
    
    [self getArticleType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
- (void)layoutSubviews {
    CGFloat catBtnWidth = 0.0;
    if (5 <= self.catsArr.count) {
        catBtnWidth = self.view.width / self.catsArr.count;
    } else {
        catBtnWidth = self.view.width / 5;
    }
    
    self.catScrollView.contentSize = CGSizeMake(catBtnWidth * self.catsArr.count, 50);
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * self.catsArr.count, self.contentScrollView.height);
    
    NSMutableArray *tableViewsArr = [NSMutableArray new];
    NSMutableDictionary *dataDic = [NSMutableDictionary new];
    
    for (NSInteger index = 0; index < self.catsArr.count; ++ index) {
        ArticleCatViewModel *viewModel = [self.catsArr objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(index * catBtnWidth, 0, catBtnWidth, 47);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setTitle:viewModel.detailStr forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#667785"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapCatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.catScrollView addSubview:btn];
        
        CustomTableView *tableView = [[CustomTableView alloc] initWithFrame:CGRectMake(5 + self.contentScrollView.width * index, 5, self.contentScrollView.width - 10, self.contentScrollView.height - 5) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.customDelegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
        tableView.tag = viewModel.typeNum.integerValue;//0:每日一句   1:其他
        [self.contentScrollView addSubview:tableView];
        [tableViewsArr addObject:tableView];
        
        if (0 == tableView.tag) {
            [tableView registerClass:[PlazaWordCell class] forCellReuseIdentifier:@"WordCell"];
            tableView.estimatedRowHeight = UITableViewAutomaticDimension;
            self.wordCell = [tableView dequeueReusableCellWithIdentifier:@"WordCell"];
        } else {
            UINib *cellNib = [UINib nibWithNibName:@"ArticleCell" bundle:nil];
            [tableView registerNib:cellNib forCellReuseIdentifier:@"ArticleCell"];
        }
        
        NSMutableArray *dataArr = [NSMutableArray new];
        [dataDic setObject:dataArr forKey:viewModel.aidStr];
        
        if ([viewModel.aidStr isEqualToString:self.catIndexStr]) {
            self.curTableView = tableView;
            self.curDataArr = dataArr;
            
            self.markView.frame = CGRectMake(catBtnWidth * index, 47, catBtnWidth, 3);
            self.markView.hidden = NO;
            
            [self.contentScrollView setContentOffset:CGPointMake(index * self.contentScrollView.width, 0) animated:YES];
            
            [self getArticleTypeListByType:viewModel.aidStr];
        }
    }
    
    self.contentsArr = [NSArray arrayWithArray:tableViewsArr];
    self.dataDic = [NSDictionary dictionaryWithDictionary:dataDic];
}

- (void)onTapCatBtn:(UIButton *)btn {
    [self showInfoByIndex:btn.tag isAnimateScrollContentView:YES];
}

- (void)showInfoByIndex:(NSInteger)index isAnimateScrollContentView:(BOOL)isAnimate {
    [UIView animateWithDuration:0.25 animations:^{
        self.markView.x = index * self.markView.width;
    } completion:^(BOOL finished) {
        ArticleCatViewModel *viewModel = [self.catsArr objectAtIndex:index];
        self.curTableView = [self.contentsArr objectAtIndex:index];
        self.curDataArr = [self.dataDic objectForKey:viewModel.aidStr];
        self.catIndexStr = viewModel.aidStr;
        
        if (0 == self.curDataArr.count) {
            [self getArticleTypeListByType:viewModel.aidStr];
        }
        
        if (isAnimate) {
            [self.contentScrollView setContentOffset:CGPointMake(index * self.contentScrollView.width, 0) animated:YES];
        }
    }];
}

#pragma mark - Networking
- (void)getArticleType {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"articleType" params:nil success:^(id responseObject) {
        
        NSMutableArray *catsArr = [NSMutableArray new];
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *catDic in resArr) {
            ArticleCatModel *model = [[ArticleCatModel alloc] initWithDic:catDic];
            ArticleCatViewModel *viewModel = [[ArticleCatViewModel alloc] initWithArticleCatModel:model];
            [catsArr addObject:viewModel];
        }
        self.catsArr = [NSArray arrayWithArray:catsArr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutSubviews];
        });
    }];
}

- (void)getArticleTypeListByType:(NSString *)typeStr {
    NSString *startIndex = @"0";
    if (self.curTableView.type == CustomTableViewUpdateTypeReloadMore) {
        startIndex = [NSString stringWithFormat:@"%zd", self.curDataArr.count];
    }
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"articleTypeList" params:@{@"type": typeStr, @"start": startIndex} success:^(id responseObject) {
        NSMutableArray *arr = [NSMutableArray new];
        
        NSMutableArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            ArticleModel *model = [[ArticleModel alloc] initWithDic:dic];
            ArticleViewModel *viewModel = [[ArticleViewModel alloc] initWithArticleModel:model];
            [arr addObject:viewModel];
        }
        
        if (self.curTableView.type == CustomTableViewUpdateTypeNone || self.curTableView.type == CustomTableViewUpdateTypeRefresh) {
            self.curDataArr = arr;
            [self.curTableView finishRefreshData];
        } else {
            [self.curDataArr addObjectsFromArray:arr];
            [self.curTableView finishReloadMoreDataWithIsEnd:(0 == arr.count)];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.curTableView reloadData];
        });
    }];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.contentScrollView]) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        [self showInfoByIndex:index isAnimateScrollContentView:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (![scrollView isEqual:self.contentScrollView]) {
        [self.curTableView.refreshView refreshScrollViewDidEndDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isEqual:self.contentScrollView]) {
        [self.curTableView.refreshView refreshScrollViewDidScroll:scrollView];
        [self.curTableView.reloadMoreView scrollViewDidScroll:scrollView];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.curDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleViewModel *viewModel = [self.curDataArr objectAtIndex:indexPath.row];
    
    if (1 == tableView.tag) {
        ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
        [cell layoutArticleCellSubviewsByArticleViewModel:viewModel];
        
        return cell;
        
    } else {
        PlazaWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WordCell"];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLab.text = viewModel.titleStr;
        cell.bgImageView.hidden = YES;
        cell.bottomLineView.hidden = NO;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (1 == tableView.tag) {
        self.selectedIndex = indexPath.row;
        [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == tableView.tag) {
        PlazaWordCell *cell = self.wordCell;
        ArticleViewModel *viewModel = [self.curDataArr objectAtIndex:indexPath.row];
        cell.textLab.text = viewModel.titleStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.bounds = CGRectMake(0, 0, tableView.width, cell.height);
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        return height;
    } else {
        return 90;
    }
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPlazaDetail"]) {
        ArticleViewModel *viewModel = [self.curDataArr objectAtIndex:self.selectedIndex];
        
        PlazaDetailViewController *controller = segue.destinationViewController;
        controller.catIndexStr = viewModel.typeStr;
        controller.articleStr = viewModel.aidStr;
        controller.title = viewModel.titleStr;
    }
}

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    [self getArticleTypeListByType:self.catIndexStr];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    [self getArticleTypeListByType:self.catIndexStr];
}

@end

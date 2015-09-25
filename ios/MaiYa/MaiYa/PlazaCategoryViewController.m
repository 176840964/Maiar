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

typedef NS_ENUM(NSInteger, ContentTableViewType){
    ContentTableViewTypeOfDeselected = 0,
    ContentTableViewTypeOfCanSelcte,
};

@interface PlazaCategoryViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *catScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) UIView *markView;
@property (strong, nonatomic) NSArray *catsArr;
@property (strong, nonatomic) NSArray *contentsArr;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) UITableView *curTableView;
@property (strong, nonatomic) NSMutableArray *curDataArr;
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
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(5 + self.contentScrollView.width * index, 5, self.contentScrollView.width - 10, self.contentScrollView.height - 5) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = viewModel.typeNum.integerValue;//0:每日一句   1:其他
        [self.contentScrollView addSubview:tableView];
        [tableViewsArr addObject:tableView];
        
        if (0 == tableView.tag) {
            UINib *cellNib = [UINib nibWithNibName:@"ArticleCell" bundle:nil];
            [tableView registerNib:cellNib forCellReuseIdentifier:@"ArticleCell"];
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
        if (isAnimate) {
            [self.contentScrollView setContentOffset:CGPointMake(index * self.contentScrollView.width, 0) animated:YES];
        }
    }];
}

#pragma mark - Networking
- (void)getArticleType {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"articleType" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            [[HintView getInstance] presentMessage:str isAutoDismiss:NO dismissBlock:nil];
        } else {
            NSMutableArray *catsArr = [NSMutableArray new];
            NSArray *resArr = [dic objectForKey:@"res"];
            for (NSDictionary *catDic in resArr) {
                ArticleCatModel *model = [[ArticleCatModel alloc] initWithDic:catDic];
                ArticleCatViewModel *viewModel = [[ArticleCatViewModel alloc] initWithArticleCatModel:model];
                [catsArr addObject:viewModel];
            }
            self.catsArr = [NSArray arrayWithArray:catsArr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutSubviews];
            });
        }
    }];
}

- (void)getArticleTypeListByType:(NSString *)typeStr {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"articleTypeList" params:@{@"type": typeStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            [[HintView getInstance] presentMessage:str isAutoDismiss:NO dismissBlock:nil];
        } else {
            NSMutableArray *resArr = [dic objectForKey:@"res"];
            for (NSDictionary *dic in resArr) {
                ArticleModel *model = [[ArticleModel alloc] initWithDic:dic];
                ArticleViewModel *viewModel = [[ArticleViewModel alloc] initWithArticleModel:model];
                [self.curDataArr addObject:viewModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.curTableView reloadData];
            });
        }
    }];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.contentScrollView]) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        [self showInfoByIndex:index isAnimateScrollContentView:NO];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.curDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleViewModel *viewModel = [self.curDataArr objectAtIndex:indexPath.row];
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    [cell layoutArticleCellSubviewsByArticleViewModel:viewModel];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

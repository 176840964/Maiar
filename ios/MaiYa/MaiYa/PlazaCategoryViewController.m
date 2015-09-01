//
//  PlazaCategoryViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaCategoryViewController.h"

@interface PlazaCategoryViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *catScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) UIView *markView;
@property (strong, nonatomic) NSArray *catsArr;
@property (strong, nonatomic) NSArray *contentsArr;
@end

@implementation PlazaCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.catsArr = @[@"话题", @"占星", @"塔罗", @"周易", @"名句"];
    self.contentsArr = [NSArray new];
    
    self.markView = [[UIView alloc] init];
    self.markView.hidden = YES;
    self.markView.backgroundColor = [UIColor colorWithHexString:@"#ee6bfe"];
    [self.catScrollView addSubview:self.markView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat catBtnWidth = 0.0;
    if (5 < self.catsArr.count) {
        catBtnWidth = self.view.width / self.catsArr.count;
    } else {
        catBtnWidth = self.view.width / 5;
    }
    
    NSMutableArray *tableViewsArr = [NSMutableArray new];
    
    for (NSInteger index = 0; index < self.catsArr.count; ++ index) {
        NSString * catStr = [self.catsArr objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(index * catBtnWidth, 0, catBtnWidth, 47);
        btn.titleLabel.font = [UIFont systemFontOfSize:19];
        [btn setTitle:catStr forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#667785"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapCatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.catScrollView addSubview:btn];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(5 + self.contentScrollView.width * index, 5, self.contentScrollView.width - 10, self.contentScrollView.height - 5) style:UITableViewStylePlain];
        [self.contentScrollView addSubview:tableView];
        [tableViewsArr addObject:tableView];
    }
    
    self.contentsArr = [NSArray arrayWithArray:tableViewsArr];
    
    self.catScrollView.contentSize = CGSizeMake(catBtnWidth * self.catsArr.count, 50);
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * self.contentsArr.count, self.contentScrollView.height);
    
    self.markView.frame = CGRectMake(0, 47, catBtnWidth, 3);
    self.markView.hidden = NO;
}

#pragma mark - 
- (void)onTapCatBtn:(UIButton *)btn {
    [UIView animateWithDuration:0.25 animations:^{
        self.markView.transform = CGAffineTransformMakeTranslation(btn.tag * btn.width, 0);
    } completion:^(BOOL finished) {
        
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

@end

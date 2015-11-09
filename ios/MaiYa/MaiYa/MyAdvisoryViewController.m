//
//  MyAdvisoryViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyAdvisoryViewController.h"
#import "MyAdvisoryCell.h"

@interface MyAdvisoryViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *inTableView;
@property (weak, nonatomic) IBOutlet UITableView *finishTableView;

@property (strong, nonatomic) NSMutableArray *inOrdersArr;
@property (strong, nonatomic) NSMutableArray *finishedOrderArr;
@end

@implementation MyAdvisoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.inOrdersArr = [NSMutableArray new];
    self.finishedOrderArr = [NSMutableArray new];
    
    [self getOrderListByType:@"1"];//进行中
    [self getOrderListByType:@"2"];//已完成
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}

#pragma mark - networking
- (void)getOrderListByType:(NSString *)type {//type == 1 进行中； type == 2 已完成；
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid;
    uid = @"1";
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderList" params:@{@"uid": uid, @"type": type} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            OrderModel *model = [[OrderModel alloc] initWithDic:dic];
            OrderViewModel *viewModel = [[OrderViewModel alloc] initWithOrderModel:model];
            
            if ([type isEqualToString:@"1"]) {
                [self.inOrdersArr addObject:viewModel];
            } else {
                [self.finishedOrderArr addObject:viewModel];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([type isEqualToString:@"1"]) {
                [self.inTableView reloadData];
            } else {
                [self.finishTableView reloadData];
            }
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

#pragma mark - IBAction
- (IBAction)onTapInBtn:(id)sender {
    self.markView.transform = CGAffineTransformIdentity;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)onTapFinishBtn:(id)sender {
    self.markView.transform = CGAffineTransformMakeTranslation(self.markView.width, 0);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.inTableView]) {
        return self.inOrdersArr.count;
    } else {
        return self.finishedOrderArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.inTableView]) {
        MyAdvisoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryInCell"];
        
        OrderViewModel *viewModel = [self.inOrdersArr objectAtIndex:indexPath.row];
        [cell layoutMyAdvisorySubviewsByOrderViewModel:viewModel];
        
        return  cell;
    } else {
        MyAdvisoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryFinishCell"];
        
        OrderViewModel *viewModel = [self.finishedOrderArr objectAtIndex:indexPath.row];
        [cell layoutMyAdvisorySubviewsByOrderViewModel:viewModel];
        
        return  cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"ShowAdvisoryDetailViewController" sender:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollView isEqual:scrollView]) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        if (0 == index) {
            self.markView.transform = CGAffineTransformIdentity;
        } else {
            self.markView.transform = CGAffineTransformMakeTranslation(self.markView.width, 0);
        }
    }
}

@end

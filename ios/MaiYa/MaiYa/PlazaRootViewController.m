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

@interface PlazaRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PlazaWordCell *commonCell;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *contentStr;
@property (strong, nonatomic) PlazaHeaderView *headerView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation PlazaRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleStr = @"test";
    self.contentStr = @"迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅";
    
    self.headerView = [[PlazaHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) * 250.0 / 750)];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[PlazaWordCell class] forCellReuseIdentifier:@"PlazaWordCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    self.commonCell = [self.tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
    
    self.dataArr = [[NSMutableArray alloc] init];
    
    NSArray *arr1 = @[@"星座：十二星座的感情自闭症", @"星座：异性面前爱装的星座女", @"星座：星座们如何对抗节后综合征"];
    NSArray *arr2 = @[@"塔罗：十二星座的感情自闭症", @"塔罗：异性面前爱装的星座女", @"塔罗：星座们如何对抗节后综合征"];
    NSArray *arr3 = @[@"周易：十二星座的感情自闭症", @"周易：异性面前爱装的星座女", @"周易：星座们如何对抗节后综合征"];
    
    [self.dataArr addObjectsFromArray:@[arr1, arr2, arr3]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        PlazaWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
        
        cell.textLab.text = self.contentStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        return cell;
    } else {
        PlazaCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"PlazaCell%zd", indexPath.row]];
        cell.tapBtnHandler = ^(NSNumber *tagNum) {
            NSString *str = @"";
            if (0 == tagNum.integerValue) {
                str = @"ShowPlazaCategory";
            } else {
                str = @"ShowPlazaDetail";
            }
            [self performSegueWithIdentifier:str sender:self];
        };
        
        NSArray *arr = [self.dataArr objectAtIndex:indexPath.row - 1];
        [cell layoutPlazaCellSubviewsByArr:arr];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath) {
        [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        PlazaWordCell *cell = self.commonCell;
        cell.textLab.text = self.contentStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.bounds = CGRectMake(0, 0, self.tableView.width, cell.height);
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        return height + 10;
    } else {
        return 112;
    }
}

@end

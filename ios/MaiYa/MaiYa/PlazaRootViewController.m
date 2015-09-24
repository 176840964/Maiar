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

@interface PlazaRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PlazaWordCell *commonCell;
@property (strong, nonatomic) PlazaHeaderView *headerView;
@property (strong, nonatomic) SquareViewModel *squareViewModel;

@property (strong, nonatomic) NSNumber *selectedCatNum;
@property (copy, nonatomic) NSString *selectedIdStr;
@end

@implementation PlazaRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerView = [[PlazaHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) * 250.0 / 750)];
    self.tableView.tableHeaderView = self.headerView;
    
    __weak typeof(self) weakSelf = self;
    self.headerView.tapHeaderViewHandle = ^(NSNumber *index) {
        [weakSelf performSegueWithIdentifier:@"ShowPlazaDetail" sender:weakSelf];
    };
    
    [self.tableView registerClass:[PlazaWordCell class] forCellReuseIdentifier:@"PlazaWordCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.commonCell = [self.tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
    
    [self getSquareData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)getSquareData {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"square" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            [[HintView getInstance] presentMessage:str isAutoDismiss:NO dismissBlock:nil];
        } else {
            NSDictionary *resDic = [dic objectForKey:@"res"];
            SquareModel *model = [[SquareModel alloc] initWithDic:resDic];
            self.squareViewModel = [[SquareViewModel alloc] initWithSquareModel:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutSubviews];
            });
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[HintView getInstance] presentMessage:@"无网络连接" isAutoDismiss:YES dismissBlock:nil];
    }];
}

- (void)layoutSubviews {
    [self.tableView reloadData];
    [self.headerView layoutPlazeHeaderViewSubviewsByArr:self.squareViewModel.focusArr];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPlazaDetail"]) {
        PlazaDetailViewController *viewController = segue.destinationViewController;
        viewController.catIndexNum = self.selectedCatNum;
        viewController.articleStr = self.selectedIdStr;
    } else if ([segue.identifier isEqualToString:@"ShowPlazaCategory"]) {
        PlazaCategoryViewController *viewController = segue.destinationViewController;
        viewController.catIndexNum = self.selectedCatNum;
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
        cell.tapBtnHandler = ^(NSNumber *catNum, NSString *idStr) {
            self.selectedCatNum = catNum;
            self.selectedIdStr = idStr;
            [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
        };
        
        cell.tapCategoryBtnHandle = ^(NSNumber *num) {
            self.selectedCatNum = num;
            [self performSegueWithIdentifier:@"ShowPlazaCategory" sender:self];
        };
        
        [cell layoutPlazaCellSubviewsByAritcleDirectoryViewModel:viewModel];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath) {
        self.selectedCatNum = [NSNumber numberWithInteger:30];
        [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
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
        
        return height + 10;
    } else {
        return 112;
    }
}

@end

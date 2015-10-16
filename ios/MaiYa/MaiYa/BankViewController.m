//
//  BankViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BankViewController.h"

@interface BankViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *banksArr;
@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getBankList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)getBankList {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"bank" params:@{} success:^(id responseObject) {
        NSMutableArray *bankArr = [NSMutableArray new];
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            BankModel *model = [[BankModel alloc] initWithDic:dic];
            BankViewModel *viewModel = [[BankViewModel alloc] initWithBankModel:model];
            [bankArr addObject:viewModel];
        }
        
        self.banksArr = [NSArray arrayWithArray:bankArr];
        
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
    return self.banksArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCell"];
    
    BankViewModel *viewModel = [self.banksArr objectAtIndex:indexPath.row];
    [cell layoutBankCellSubviewsByBankViewModel:viewModel];
    
    cell.selectedImageView.hidden = ![viewModel.bankIdStr isEqualToString:self.selectedBackIdStr];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BankViewModel *viewModel = [self.banksArr objectAtIndex:indexPath.row];
    self.selectedBackIdStr = viewModel.bankIdStr;
    
    [tableView reloadData];
    self.didSelectedHandle(viewModel);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

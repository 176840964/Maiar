//
//  BankCityViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BankCityViewController.h"

@interface BankCityViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *areasArr;
@end

@implementation BankCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getAreaList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)getAreaList {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"area" params:@{} success:^(id responseObject) {
        NSMutableArray *areaArr = [NSMutableArray new];
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            AreaModel *model = [[AreaModel alloc] initWithDic:dic];
            AreaViewModel *viewModel = [[AreaViewModel alloc] initWithAreaModel:model];
            [areaArr addObject:viewModel];
        }
        
        self.areasArr = [NSArray arrayWithArray:areaArr];
        
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
    return self.areasArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCityCell"];
    
    AreaViewModel *viewModel = [self.areasArr objectAtIndex:indexPath.row];
    [cell layoutBankCellSubviewsByAreaViewModel:viewModel];
    
    cell.selectedImageView.hidden = ![viewModel.areaIdStr isEqualToString:self.selectedAreaIdStr];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AreaViewModel *viewModel = [self.areasArr objectAtIndex:indexPath.row];
    self.selectedAreaIdStr = viewModel.areaIdStr;
    
    [tableView reloadData];
    self.didSelectedHandle(viewModel);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

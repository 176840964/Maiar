//
//  MyCollectionViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MasterCell.h"

@interface MyCollectionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
    
    self.dataArr = [NSMutableArray new];
    
    [self getCollectList];
}

#pragma mark - 
- (void)getCollectList {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid
    uid = @"1";
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"collectList" params:@{@"uid": uid} success:^(id responseObject) {
        NSArray *resDic = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resDic) {
            UserZoneModel *model = [[UserZoneModel alloc] initWithDic:dic];
            UserZoneViewModel *viewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
            [self.dataArr addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    UserZoneViewModel *viewModel = [self.dataArr objectAtIndex:indexPath.row];
    [cell layoutMasterCellSubviewsByUserZoneViewModel:viewModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

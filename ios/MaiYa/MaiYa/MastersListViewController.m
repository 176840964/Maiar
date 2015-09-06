//
//  MastersListViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/6.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MastersListViewController.h"
#import "MasterCell.h"

@interface MastersListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MastersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

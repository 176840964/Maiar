//
//  AdvisoryDetailViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailViewController.h"
#import "AdvisoryDetailTimeCell.h"

@interface AdvisoryDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AdvisoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailNumCell"];
            break;
            
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailTypeCell"];
            break;
            
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailMasterCell"];
            break;
            
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailUserCell"];
            break;
            
        case 4:{
            AdvisoryDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailTimeCell"];
            [cell layoutAdvisoryDetailTimeCellSubviews];
            return cell;
        }
            
        case 5:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailServiceCell"];
            break;
            
        case 6:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailCommentCell"];
            break;
            
        case 7:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailEndCell"];
            break;
            
        case 8:
            cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailPayCell"];
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:
            height = 58;
            break;
            
        case 1:
            height = 41 ;
            break;
            
        case 2:
            height = 104;
            break;
            
        case 3:
            height = 104;
            break;
            
        case 4:
            height = 33 + 70 * 7;
            break;
            
        case 5:
            height = 80;
            break;
            
        case 6:
            height = 340;
            break;
            
        case 7:
            height = 172;
            break;
            
        case 8:
            height = 132;
            break;
    }
    
    return height;
}

@end

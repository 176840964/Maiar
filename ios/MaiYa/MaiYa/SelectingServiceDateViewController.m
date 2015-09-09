//
//  SelectingServiceDateViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "SelectingServiceDateViewController.h"
#import "SelectingServiceTimeCell.h"
#import "SelectingServiceDateCell.h"

@interface SelectingServiceDateViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutletCollection(SelectingServiceDateCell) NSArray *dayCell;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayLab;
@property (weak, nonatomic) IBOutlet UITableView *talbeView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation SelectingServiceDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dayCell = [self.dayCell sortByUIViewOriginX];
    
    self.dataArr = [NSMutableArray new];
    
    NSArray *arr0 = @[@"09:00-10:00", @"10:00-11:00", @"11:00-12:00"];
    NSDictionary *dic0 = @{@"section": @"上午", @"time": arr0};
    [self.dataArr addObject:dic0];
    
    NSArray *arr1 = @[@"13:00-14:00", @"14:00-15:00"];
    NSDictionary *dic1 = @{@"section": @"中午", @"time": arr1};
    [self.dataArr addObject:dic1];
    
    NSArray *arr2 = @[@"20:00-21:00"];
    NSDictionary *dic2 = @{@"section": @"下午", @"time": arr2};
    [self.dataArr addObject:dic2];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = [self.dataArr objectAtIndex:section];
    NSArray *arr = [dic objectForKey:@"time"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectingServiceTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell"];
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.section];
    NSArray *arr = [dic objectForKey:@"time"];
    NSString *title = [arr objectAtIndex:indexPath.row];
    cell.titleLab.text = title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = [self.dataArr objectAtIndex:section];
    NSString *str = [dic objectForKey:@"section"];
    return str;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

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
#import "ConsultantTimeModel.h"

@interface SelectingServiceDateViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutletCollection(SelectingServiceDateCell) NSArray *dayCell;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayLab;
@property (weak, nonatomic) IBOutlet UITableView *talbeView;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) ConsultantTimeViewModel *timeViewModel;
@end

@implementation SelectingServiceDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataDic = [NSDictionary new];
    
    [self getUserTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)onTapDayView:(SelectingServiceDateCell *)dayCell {
    for (NSInteger index = 0; index < self.dayCell.count; index ++) {
        SelectingServiceDateCell *dayView = [self.dayCell objectAtIndex:index];
        if ([dayView isEqual:dayCell]) {
            dayView.backgroundColor = [UIColor colorWithR:243 g:62 b:118];
            self.selectedDayLab.text = dayCell.dailyViewModel.theFullTimeStr;
            
            ConsultantDailyViewModel *daily = [self.timeViewModel.dailyArr objectAtIndex:index];
            self.dataDic = [daily canSelectHourlyDataDic];
            
            if (self.dataDic.allKeys.count > 0) {
                self.talbeView.hidden = NO;
                [self.talbeView reloadData];
            } else {
                self.talbeView.hidden = YES;
            }
        } else {
            dayView.backgroundColor = [UIColor colorWithR:95 g:80 b:154];
        }
    }
}

- (void)layoutSubviews {
    self.dayCell = [self.dayCell sortByUIViewOriginX];
    
    for (NSInteger index = 0; index < self.dayCell.count; index ++) {
        SelectingServiceDateCell *dateCell = [self.dayCell objectAtIndex:index];
        [dateCell addTarget:self action:@selector(onTapDayView:) forControlEvents:UIControlEventTouchUpInside];
        
        ConsultantDailyViewModel *viewModel = [self.timeViewModel.dailyArr objectAtIndex:index];
        [dateCell layoutSelectingServiceDateCellSubviewsByConsultantDailyViewModel:viewModel];
        
        if (0 == index) {
            [self onTapDayView:dateCell];
        }
    }
}

#pragma mark - NetWorking
- (void)getUserTime {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userTime" params:@{@"cid": self.masterId, @"count": @"7"} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        ConsultantTimeModel *model = [[ConsultantTimeModel alloc] initWithDic:resDic];
        self.timeViewModel = [[ConsultantTimeViewModel alloc] initWithConsultantTimeModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutSubviews];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.dataDic.allKeys objectAtIndex:section];
    NSArray *arr = [self.dataDic objectForKey:key];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectingServiceTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell"];
    
    NSString *key = [self.dataDic.allKeys objectAtIndex:indexPath.section];
    NSArray *arr = [self.dataDic objectForKey:key];
    cell.titleLab.text = [arr objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *str = [self.dataDic.allKeys objectAtIndex:section];
    if ([str isEqualToString:@"am"]) {
        return @"上午";
    } else if ([str isEqualToString:@"pm"]) {
        return @"下午";
    } else {
        return @"晚上";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

//
//  WorkingSettingViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WorkingSettingViewController.h"
#import "WorkingDateView.h"
#import "WorkingTimeCell.h"
#import "ConsultantTimeModel.h"

@interface WorkingSettingViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet WorkingDateView *dateView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ConsultantTimeViewModel *timeViewModel;
@property (strong, nonatomic) ConsultantDailyViewModel *selectedDailyViewModel;
@end

@implementation WorkingSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *cellNib = [UINib nibWithNibName:@"WorkingTimeCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"WorkingTimeCell"];
    
    [self getWorkingTime];
    
    __weak typeof(self) weakSelf = self;
    self.dateView.selectedDateHandle = ^(NSNumber *indexNum) {
        [weakSelf saveWorkingTimeBySelectedDaily:weakSelf.selectedDailyViewModel];//切换时更新
        weakSelf.selectedDailyViewModel = [weakSelf.timeViewModel.dailyArr objectAtIndex:indexNum.integerValue];
        [weakSelf.tableView reloadData];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)getWorkingTime {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userTime" params:@{@"cid": @"1", @"count": @"7"} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        ConsultantTimeModel *model = [[ConsultantTimeModel alloc] initWithDic:resDic];
        self.timeViewModel = [[ConsultantTimeViewModel alloc] initWithConsultantTimeModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dateView layoutWorkingDateViewSubviewsByDateArr:self.timeViewModel.dailyArr];
        });
    }];
}

- (void)saveWorkingTimeBySelectedDaily:(ConsultantDailyViewModel *)selectedDaily {
    if (selectedDaily && selectedDaily.isNeedToUpdate) {
        [[NetworkingManager shareManager] networkingWithGetMethodPath:@"editUserTime" params:@{@"uid": @"1", @"time": selectedDaily.timestampStr, @"time_slot": selectedDaily.updateHorlyStateStr} success:^(id responseObject) {
            
        }];
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __weak typeof(self) weakSelf = self;
    self.tapNaviRightBtnHandler = ^() {
        [weakSelf saveWorkingTimeBySelectedDaily:weakSelf.selectedDailyViewModel];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [super prepareForSegue:segue sender:sender];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 5;
        default:
            return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkingTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkingTimeCell"];
    
    NSString *titleStr = @"";
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:
                    titleStr = @"09:00-10:00";
                    break;
                case 1:
                    titleStr = @"10:00-11:00";
                    break;
                default:
                    titleStr = @"11:00-12:00";
                    break;
            }
        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:
                    titleStr = @"13:00-14:00";
                    break;
                case 1:
                    titleStr = @"14:00-15:00";
                    break;
                case 2:
                    titleStr = @"15:00-16:00";
                    break;
                case 3:
                    titleStr = @"16:00-17:00";
                    break;
                default:
                    titleStr = @"17:00-18:00";
                    break;
            }
        }
            break;
            
        default:
            switch (indexPath.row) {
                case 0:
                    titleStr = @"19:00-20:00";
                    break;
                case 1:
                    titleStr = @"20:00-21:00";
                    break;
                case 2:
                    titleStr = @"21:00-22:00";
                    break;
                default:
                    titleStr = @"22:00-23:00";
                    break;
            }
            break;
    }
    
    cell.titleLab.text = titleStr;
    NSInteger titleIntegerValue = titleStr.integerValue;
    NSString *stateValueStr = [self.selectedDailyViewModel.horlyStateArr objectAtIndex:titleIntegerValue];
    cell.markImageView.hidden = NO;
    switch (stateValueStr.integerValue) {
        case 1:
            cell.markImageView.image = [UIImage imageNamed:@"timeCanSelect"];
            break;
        case 2:
            cell.markImageView.image = [UIImage imageNamed:@"timeReserved"];
            break;
        case 3:
            cell.markImageView.image = [UIImage imageNamed:@"timeRest"];
            break;
        default:
            cell.markImageView.hidden = YES;
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"上午";
            
        case 1:
            return @"下午";
            
        default:
            return @"晚上";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkingTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *hourStr = cell.titleLab.text;
    NSString *stateValueStr = [self.selectedDailyViewModel.horlyStateArr objectAtIndex:hourStr.integerValue];
    if ([stateValueStr isEqualToString:@"1"]) {
        cell.markImageView.image = [UIImage imageNamed:@"timeRest"];
        [self.selectedDailyViewModel.horlyStateArr replaceObjectAtIndex:hourStr.integerValue withObject:@"3"];
    } else if ([stateValueStr isEqualToString:@"3"]) {
        cell.markImageView.image = [UIImage imageNamed:@"timeCanSelect"];
        [self.selectedDailyViewModel.horlyStateArr replaceObjectAtIndex:hourStr.integerValue withObject:@"1"];
    }
}

@end

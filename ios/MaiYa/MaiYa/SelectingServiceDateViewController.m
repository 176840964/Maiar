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

@interface SelectingServiceDateViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutletCollection(SelectingServiceDateCell) NSArray *dayCell;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayLab;
@property (weak, nonatomic) IBOutlet UIView *noTimeView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) ConsultantTimeViewModel *timeViewModel;
@property (copy, nonatomic) NSString *selectedDateTimestampStr;
@end

@implementation SelectingServiceDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataDic = [NSDictionary new];
    
    [self getUserTime];
    
    self.nextBtn.enabled = [UserConfigManager shareManager].createOrderViewModel.isHasSelectedTime;
    [[UserConfigManager shareManager].createOrderViewModel addObserver:self forKeyPath:@"isHasSelectedTime" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([UserConfigManager shareManager].createOrderViewModel.isHasErrorTime) {
        [self getUserTime];
    }
}

- (void)dealloc {
    [[UserConfigManager shareManager].createOrderViewModel removeObserver:self forKeyPath:@"isHasSelectedTime"];
}

#pragma mark - 
- (void)onTapDayView:(SelectingServiceDateCell *)dayCell {
    for (NSInteger index = 0; index < self.dayCell.count; index ++) {
        SelectingServiceDateCell *dayView = [self.dayCell objectAtIndex:index];
        if ([dayView isEqual:dayCell]) {
            dayView.backgroundColor = [UIColor colorWithR:243 g:62 b:118];
            self.selectedDayLab.text = dayCell.dailyViewModel.theFullTimeStr;
            
            ConsultantDailyViewModel *daily = [self.timeViewModel.dailyArr objectAtIndex:index];
            self.dataDic = daily.canSelectHourlyDataDic;
            self.selectedDateTimestampStr = daily.timestampStr;
            
            if (self.dataDic.allKeys.count > 0) {
                self.noTimeView.hidden = YES;
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            } else {
                self.noTimeView.hidden = NO;
                self.tableView.hidden = YES;
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

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isHasSelectedTime"]) {
        self.nextBtn.enabled = [UserConfigManager shareManager].createOrderViewModel.isHasSelectedTime;
        if ([UserConfigManager shareManager].createOrderViewModel.isHasSelectedTime) {
            self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"#a773af"];
        } else {
            self.nextBtn.backgroundColor = [UIColor lightGrayColor];
        }
    }
}

#pragma mark - IBAction
- (IBAction)onTapBackNaviItem:(id)sender {
    [CustomTools alertShow:@"您尚未完成订单" content:@"您是要继续还是放弃？" cancelBtnTitle:@"继续" okBtnTitle:@"放弃" container:self];
}

#pragma mark - NetWorking
- (void)getUserTime {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userTime" params:@{@"cid": self.masterId, @"count": @"7"} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        ConsultantTimeModel *model = [[ConsultantTimeModel alloc] initWithDic:resDic];
        self.timeViewModel = [[ConsultantTimeViewModel alloc] initWithConsultantTimeModel:model];
        
        if ([UserConfigManager shareManager].createOrderViewModel.isHasErrorTime) {//出现错误订单时间
            
            NSMutableDictionary *timeDic = [UserConfigManager shareManager].createOrderViewModel.timeDic;
            
            for (NSString *key in timeDic.allKeys) {
                BOOL isValidTimestamp = NO;//是否是有效的时间挫，例如跨天后，之前选择的时间挫是无效的
                
                for (ConsultantDailyViewModel *daily in self.timeViewModel.dailyArr) {
                    if ([key isEqualToString:daily.timestampStr]) {
                        isValidTimestamp = YES;
                        NSMutableArray *userSelectedTimeArr = [timeDic objectForKey:key];
                        NSMutableArray *needRemoveArr = [NSMutableArray new];
                        for (NSString *selectedTime in userSelectedTimeArr) {
                            NSString *sectionKey = nil;
                            if (selectedTime.integerValue >= 9 && selectedTime.integerValue <= 11) {
                                sectionKey = @"0";
                            } else if (selectedTime.integerValue >= 13 && selectedTime.integerValue <= 17) {
                                sectionKey = @"1";
                            } else if (selectedTime.integerValue >= 19 && selectedTime.integerValue <= 22){
                                sectionKey = @"2";
                            }
                            
                            NSArray *hourlyArr = [daily.canSelectHourlyDataDic objectForKey:sectionKey];
                            BOOL isContains = [hourlyArr containsObject:selectedTime];
                            if (!isContains) {
                                [needRemoveArr addObject:selectedTime];
                            }
                        }
                        
                        if (needRemoveArr.count > 0) {
                            [userSelectedTimeArr removeObjectsInArray:needRemoveArr];
                        }
                        
                        break;
                    }
                }
                
                if (isValidTimestamp) {
                    continue;
                } else {
                    [timeDic removeObjectForKey:key];
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutSubviews];
            if ([UserConfigManager shareManager].createOrderViewModel.isHasErrorTime) {
                [self.tableView reloadData];
                [UserConfigManager shareManager].createOrderViewModel.isHasErrorTime = NO;
            }
        });
    }];
}

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
    cell.isSelected = NO;
    
    NSMutableDictionary *dic = [UserConfigManager shareManager].createOrderViewModel.timeDic;
    NSMutableArray *timeArr = [dic objectForKey:self.selectedDateTimestampStr];
    if (timeArr) {
        for (NSString *string in timeArr) {
            if ([cell.titleLab.text isEqualToString:string]) {
                cell.isSelected = YES;
                break;
            }
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *str = [self.dataDic.allKeys objectAtIndex:section];
    if ([str isEqualToString:@"0"]) {
        return @"上午";
    } else if ([str isEqualToString:@"1"]) {
        return @"下午";
    } else {
        return @"晚上";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SelectingServiceTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
    
    NSMutableDictionary *dic = [UserConfigManager shareManager].createOrderViewModel.timeDic;
    NSMutableArray *arr = [dic objectForKey:self.selectedDateTimestampStr];
    if (cell.isSelected) {
        if (arr) {
            [arr addObject:cell.titleLab.text];
        } else {
            arr = [NSMutableArray new];
            [arr addObject:cell.titleLab.text];
            [dic setObject:arr forKey:self.selectedDateTimestampStr];
        }
    } else {
        [arr removeObject:cell.titleLab.text];
        if (arr.count == 0) {
            [dic removeObjectForKey:self.selectedDateTimestampStr];
        }
    }
    
    [UserConfigManager shareManager].createOrderViewModel.isHasSelectedTime = (dic.allKeys.count != 0);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex != buttonIndex) {
        [[UserConfigManager shareManager].createOrderViewModel clear];
        
        UIViewController *controller = [self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:controller animated:YES];
    }
}

@end

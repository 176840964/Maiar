//
//  MyZoneViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyZoneViewController.h"
#import "UserZoneModel.h"
#import "ZoneWorkingTimeView.h"

@interface MyZoneViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeight;
@property (weak, nonatomic) IBOutlet ZoneWorkingTimeView *zoneWorkingTimeView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) UserZoneViewModel *userZoneViewModel;

@end

@implementation MyZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomView.hidden = (ZoneViewControllerTypeOfMine == self.type);
    
    [self getUserInfo];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat height = 671 + 20 + 107.0 / 320 * self.view.width + ((ZoneViewControllerTypeOfOther == self.type) ? 58 : 0);
    self.mainViewHeight.constant = height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - 
- (void)layoutWorkingTime {
    [self.zoneWorkingTimeView layoutZoneWorkingTimeViewSubviewsByWorkTimeStatusArr:self.userZoneViewModel.workTimeStatusArr];
}

#pragma mark - Networking
- (void)getUserInfo {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userInfo" params:@{@"cid": @"1"} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        UserZoneModel *model = [[UserZoneModel alloc] initWithDic:resDic];
        self.userZoneViewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutWorkingTime];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapSharingSettingBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowMySharingViewController" sender:self];
}

- (IBAction)onTapSharingMoreBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowMySharingViewController" sender:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.bottomView.hidden) {
        [UIView animateWithDuration:.5 animations:^{
            self.bottomView.transform = CGAffineTransformMakeTranslation(0, self.bottomView.height);
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.bottomView.hidden) {
        [UIView animateWithDuration:.5 animations:^{
            self.bottomView.transform = CGAffineTransformIdentity;
        }];
    }
}

@end

//
//  MyZoneViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyZoneViewController.h"
#import "WorkingTimeViewController.h"

@interface MyZoneViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeight;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *workingTimeCellView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) NSMutableArray *testArr;

@end

@implementation MyZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.workingTimeCellView = [self.workingTimeCellView sortByUIViewOriginX];
    
    self.bottomView.hidden = (ZoneViewControllerTypeOfMine == self.type);
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat height = 671 + 20 + 107.0 / 320 * self.view.width + ((ZoneViewControllerTypeOfOther == self.type) ? 58 : 0);
    self.mainViewHeight.constant = height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier containsString:@"ShowWorkTime"]) {
        NSArray *arr = [segue.identifier componentsSeparatedByString:@"_"];
        NSInteger index = ((NSString*)[arr lastObject]).integerValue;
        
        WorkingTimeViewController *controller = segue.destinationViewController;
        controller.testArr = [NSArray arrayWithArray:[self.testArr objectAtIndex:index]];
    }
}

- (NSMutableArray *)testArr {
    if (nil == _testArr) {
        _testArr = [NSMutableArray new];
        
        NSArray* arr0 = @[@"一", @"8.20", @"上", @"下", @"晚"];
        NSArray* arr1 = @[@"二", @"8.21", @"上", @"下", @"晚"];
        NSArray* arr2 = @[@"三", @"8.22", @"上", @"下", @"晚"];
        NSArray* arr3 = @[@"四", @"8.23", @"上", @"下", @"晚"];
        NSArray* arr4 = @[@"五", @"8.24", @"上", @"下", @"晚"];
        NSArray* arr5 = @[@"六", @"8.25", @"上", @"下", @"晚"];
        NSArray* arr6 = @[@"日", @"8.26", @"上", @"下", @"晚"];
        [_testArr addObjectsFromArray:@[arr0, arr1, arr2, arr3, arr4, arr5, arr6]];
    }
    
    return _testArr;
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

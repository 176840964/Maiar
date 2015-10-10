//
//  BaseViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/19.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"
#import "NaviTopViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddTopView"]) {
        NaviTopViewController* controller = segue.destinationViewController;
        controller.titleLabStr = self.titleLabStr;
        controller.backBtnTitle = self.backBtnTitle;
        controller.rightBtnImgStr = self.rightBtnImgStr;
        controller.rightSecondBtnImgStr = self.rightSecondBtnImgStr;
        
        __weak typeof(self) weakSelf = self;
        controller.tapBackBtnHandler = ^() {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        controller.tapRightBtnHandler = self.tapNaviRightBtnHandler;
        controller.tapRightSecondBtnHandler = self.tapNaviRightSecondBtnHandler;
    }
}

#pragma mark - IBAction
- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

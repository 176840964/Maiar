//
//  MyZoneViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyZoneViewController.h"

@interface MyZoneViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeight;

@end

@implementation MyZoneViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.mainViewHeight.constant = 716 * 2;
}

@end

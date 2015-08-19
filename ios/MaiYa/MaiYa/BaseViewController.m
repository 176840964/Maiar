//
//  BaseViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/19.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

#pragma mark - IBAction
- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

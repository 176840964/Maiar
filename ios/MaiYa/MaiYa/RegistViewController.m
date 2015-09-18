//
//  RegistViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/19.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "RegistViewController.h"

@implementation RegistViewController

#pragma mark - IBAction
- (IBAction)onTapRegistBtn:(id)sender {
    
    
    [[HintView getInstance] presentMessage:@"注册成功" isAutoDismiss:YES dismissBlock:nil];
}

- (IBAction)onTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

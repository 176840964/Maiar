//
//  LoginViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/18.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic, weak) IBOutlet UITextField *telNumTextFiled;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextFiled;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.telNumTextFiled becomeFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.telNumTextFiled resignFirstResponder];
    [self.passwordTextFiled resignFirstResponder];
}

#pragma mark - IBAction
- (IBAction)onTapLoginBtn:(id)sender {
    [UserConfigManager shareManager].userTelNumStr = @"1";
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    __weak typeof(self) weakSelf = self;
//    [[HintView getInstance] presentMessage:@"登录成功" isAutoDismiss:YES dismissBlock:^{
//        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//    }];
}

@end

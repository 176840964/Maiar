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

#pragma mark - IBAction
- (IBAction)onTapLoginBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  LoginViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/18.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfoModel.h"

@interface LoginViewController ()
@property (nonatomic, weak) IBOutlet UITextField *telNumTextFiled;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextFiled;
@property (nonatomic, weak) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *validTelFiled = [self.telNumTextFiled.rac_textSignal map:^id(NSString *text) {
        return @([CustomTools is11DigitNumber:text]);
    }];
    
    RACSignal *validPWFiled = [self.passwordTextFiled.rac_textSignal map:^id(NSString *text) {
        return @([CustomTools isValidPassword:text]);
    }];
    
    RAC(self.loginBtn, enabled) = [RACSignal combineLatest:@[validTelFiled, validPWFiled] reduce:^id(NSNumber *telValid, NSNumber *pwValid){
        if (telValid.boolValue && pwValid.boolValue) {
            self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"#bb57f4"];
        } else {
            self.loginBtn.backgroundColor = [UIColor lightGrayColor];
        }
        
        return @(telValid.boolValue && pwValid.boolValue);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - IBAction
- (IBAction)onTapLoginBtn:(id)sender {
    [self.telNumTextFiled resignFirstResponder];
    [self.passwordTextFiled resignFirstResponder];
    
    NSLog(@"pw:%@", [CustomTools md5:self.passwordTextFiled.text]);
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"login" params:@{@"username": self.telNumTextFiled.text, @"password": [CustomTools md5:self.passwordTextFiled.text], @"area_code": @"+86"} success:^(id responseObject) {
        
        NSDictionary *dic = [responseObject objectForKey:@"res"];
        UserInfoModel *model = [[UserInfoModel alloc] initWithDic:dic];
        UserInfoViewModel *viewModel = [[UserInfoViewModel alloc] initWithModel:model];
        [UserConfigManager shareManager].userInfo = viewModel;
        [UserConfigManager shareManager].isLogin = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HintView getInstance] presentMessage:@"登录成功" isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        });
    }];
}

#pragma mark - LoginBaseViewControllerDelegate
- (void)loginBaseViewControllerShowKeyboard:(LoginBaseViewController *)loginBaseViewController {
    CGRect frame = [self.view convertRect:self.loginBtn.frame fromView:self.contentView];
    [self converScrollViewContentSizeWithButtonFrame:frame];
}

- (void)loginBaseViewControllerHiddenKeyboard:(LoginBaseViewController *)loginBaseViewController {
    [self.telNumTextFiled resignFirstResponder];
    [self.passwordTextFiled resignFirstResponder];
}

@end

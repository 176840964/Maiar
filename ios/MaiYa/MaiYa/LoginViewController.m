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
    
    [self.telNumTextFiled becomeFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.telNumTextFiled resignFirstResponder];
    [self.passwordTextFiled resignFirstResponder];
}

#pragma mark - IBAction
- (IBAction)onTapLoginBtn:(id)sender {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"login" params:@{@"username": self.telNumTextFiled.text, @"password": self.passwordTextFiled.text, @"area_code": @"+86"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            [[HintView getInstance] presentMessage:str isAutoDismiss:NO dismissBlock:nil];
        } else {
            NSDictionary *res = [dic objectForKey:@"res"];
            UserInfoModel *model = [[UserInfoModel alloc] initWithDic:res];
            UserInfoViewModel *viewModel = [[UserInfoViewModel alloc] initWithModel:model];
            [UserConfigManager shareManager].userInfo = viewModel;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[HintView getInstance] presentMessage:@"登录成功" isAutoDismiss:YES dismissBlock:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            });
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[HintView getInstance] presentMessage:@"登录失败" isAutoDismiss:YES dismissBlock:nil];
    }];
}

@end

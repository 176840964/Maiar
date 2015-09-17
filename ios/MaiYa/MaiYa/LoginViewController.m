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
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"login" params:@{@"username": self.telNumTextFiled.text, @"password": self.passwordTextFiled.text, @"area_code": @"+86"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            [[HintView getInstance] presentMessage:@"登录失败" isAutoDismiss:NO dismissBlock:nil];
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
        NSLog(@"%@", error);
        [[HintView getInstance] presentMessage:@"登录失败" isAutoDismiss:NO dismissBlock:nil];
    }];
}

@end

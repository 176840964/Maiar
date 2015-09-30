//
//  RegistViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/19.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telNumTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *msgTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (strong, nonatomic) NSTimer *countTimer;
@property (assign, nonatomic) NSInteger countIndex;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *validTelFiled = [self.telNumTextFiled.rac_textSignal map:^id(NSString *text) {
        return @([CustomTools is11DigitNumber:text]);
    }];
    
    RAC(self.msgBtn, enabled) = [RACSignal combineLatest:@[validTelFiled] reduce:^id(NSNumber *telValid){
        if (telValid.boolValue) {
            self.msgBtn.backgroundColor = [UIColor colorWithHexString:@"#6db82a"];
        } else {
            self.msgBtn.backgroundColor = [UIColor lightGrayColor];
            if (self.countTimer.isValid) {
                [self setMessageCodeBtnNormalType];
            }
        }
        
        return @(telValid.boolValue);
    }];
    
    RACSignal *validMsgFiled = [self.msgTextFiled.rac_textSignal map:^id(NSString *text) {
        return @([CustomTools isValidPassword:text]);
    }];
    
    RACSignal *validPWFiled = [self.pwTextFiled.rac_textSignal map:^id(NSString *text) {
        return @([CustomTools isValidPassword:text]);
    }];
    
    RAC(self.registBtn, enabled) = [RACSignal combineLatest:@[validTelFiled, validMsgFiled, validPWFiled] reduce:^id(NSNumber *telValid, NSNumber *msgValid, NSNumber *pwValid){
        if (telValid.boolValue && msgValid.boolValue && pwValid.boolValue) {
            self.registBtn.backgroundColor = [UIColor colorWithHexString:@"#bb57f4"];
        } else {
            self.registBtn.backgroundColor = [UIColor lightGrayColor];
        }
        
        return @(telValid.boolValue && msgValid.boolValue && pwValid.boolValue);
    }];
}

- (void)dealloc {
    [self.countTimer invalidate];
}

- (void)oneMinuteCountdown {
    self.msgBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.msgBtn setTitle:[NSString stringWithFormat:@"%zd", self.countIndex] forState:UIControlStateNormal];
    
    self.countTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)countdown {
    if (0 != self.countIndex) {
        self.countIndex --;
        [self.msgBtn setTitle:[NSString stringWithFormat:@"%zd", self.countIndex] forState:UIControlStateNormal];
    } else {
        [self setMessageCodeBtnNormalType];
    }
}

- (void)setMessageCodeBtnNormalType {
    [self.countTimer invalidate];
    
    self.msgBtn.backgroundColor = [UIColor colorWithHexString:@"#6db82a"];
    [self.msgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.msgBtn.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)autoLoginWhenEndRegistWithUid:(NSString *)uid {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"login" params:@{@"username": self.telNumTextFiled.text, @"password": [CustomTools md5:self.pwTextFiled.text], @"area_code": @"+86"} success:^(id responseObject) {
        
        NSDictionary *res = [responseObject objectForKey:@"res"];
        UserInfoModel *model = [[UserInfoModel alloc] initWithDic:res];
        UserInfoViewModel *viewModel = [[UserInfoViewModel alloc] initWithModel:model];
        [UserConfigManager shareManager].userInfo = viewModel;
        [UserConfigManager shareManager].isLogin = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HintView getInstance] presentMessage:@"登录成功" isAutoDismiss:YES dismissBlock:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapMsgBtn:(id)sender {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"getCode" params:@{@"username": self.telNumTextFiled.text, @"type": @"1", @"area_code": @"+86"} success:^(id responseObject) {
        
        [self.msgTextFiled becomeFirstResponder];
        self.msgBtn.backgroundColor = [UIColor lightGrayColor];
        self.countIndex = 60;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self oneMinuteCountdown];
        });
    }];
}

- (IBAction)onTapRegistBtn:(id)sender {
    [self.telNumTextFiled resignFirstResponder];
    [self.msgTextFiled resignFirstResponder];
    [self.pwTextFiled resignFirstResponder];
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"regist" params:@{@"username": self.telNumTextFiled.text, @"password": [CustomTools md5:self.pwTextFiled.text], @"yzm": self.msgTextFiled.text, @"area_code": @"+86"} success:^(id responseObject) {
        
        NSDictionary *dic = [responseObject objectForKey:@"res"];
        NSNumber *uid = [dic objectForKey:@"uid"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HintView getInstance] presentMessage:@"注册成功,自动登录" isAutoDismiss:YES dismissBlock:^{
                [self autoLoginWhenEndRegistWithUid:uid.stringValue];
            }];
        });
    }];
}

- (IBAction)onTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

//
//  UserNameViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserNameViewController.h"

@interface UserNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameTextField.placeholder = self.nickStr;
}

#pragma mark - 
- (void)editUserName {
    if (self.usernameTextField.text.length == 0) {
        [CustomTools simpleAlertShow:@"错误" content:@"用户昵称不能为空" container:nil];
        return;
    } else if (self.usernameTextField.text.length > 6) {
        [CustomTools simpleAlertShow:@"错误" content:@"用户昵称不能超过6个字符" container:nil];
        return;
    }
    
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"editUserInfo" params:@{@"uid": uid, @"nick": self.usernameTextField.text} success:^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __weak typeof(self) weakSelf = self;
    self.tapNaviRightBtnHandler = ^() {
        [weakSelf editUserName];
    };
    
    [super prepareForSegue:segue sender:sender];
}

@end

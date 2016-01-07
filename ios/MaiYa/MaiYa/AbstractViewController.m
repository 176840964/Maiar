//
//  AbstractViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AbstractViewController.h"

@interface AbstractViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation AbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.text = self.abstractStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 480) {
        self.textViewHeight.constant = 110;
    }
}

#pragma mark - 
- (void)editUserAbstract {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"editUserInfo" params:@{@"uid": uid, @"introduce": self.textView.text} success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapSaveItem:(id)sender {
    [self editUserAbstract];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
}

@end

//
//  LoginBaseViewController.m
//  MaiYa
//
//  Created by zxl on 15/12/22.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "LoginBaseViewController.h"

@interface LoginBaseViewController ()
@property (assign, nonatomic) CGRect kbRect;
@end

@implementation LoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [self.contentView addTarget:self action:@selector(onTapContentView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.viewHeight.constant = CGRectGetHeight([UIScreen mainScreen].bounds) - 64;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)converScrollViewContentSizeWithButtonFrame:(CGRect)frame {
    if (CGRectGetMaxY(frame) > CGRectGetMinY(self.kbRect)) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64 + CGRectGetMaxY(frame) + 15 - CGRectGetMinY(self.kbRect));
    }
}

#pragma mark -
- (void)showKeyboard:(NSNotification *)notify {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginBaseViewControllerShowKeyboard:)]) {
        self.kbRect = [[notify.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        [self.delegate loginBaseViewControllerShowKeyboard:self];
    }
}

- (void)onTapContentView:(UIControl *)ctrl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginBaseViewControllerHiddenKeyboard:)]) {
        [self.delegate loginBaseViewControllerHiddenKeyboard:self];
        self.scrollView.contentSize = self.contentView.frame.size;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - LoginBaseViewControllerDelegate
- (void)loginBaseViewControllerShowKeyboard:(LoginBaseViewController *)loginBaseViewController {
    
}

- (void)loginBaseViewControllerHiddenKeyboard:(LoginBaseViewController *)loginBaseViewController {
    
}

@end

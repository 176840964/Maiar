//
//  CompletWithdrawals.m
//  MaiYa
//
//  Created by zxl on 15/10/19.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "CompletWithdrawals.h"

@interface CompletWithdrawals ()

@end

@implementation CompletWithdrawals

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isBackToRootViewController = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapCompletBtn:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]  animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

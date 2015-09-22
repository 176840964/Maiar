//
//  TabBarViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/12.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.barTintColor = [UIColor colorWithR:240 g:241 b:247];
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#ee6bfe"];
    
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    item0.selectedImage = [UIImage imageNamed:@"guangchang_h"];
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    item1.selectedImage = [UIImage imageNamed:@"zixun_h"];
    
//    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
//    item2.selectedImage = [UIImage imageNamed:@"xiaoxi_h"];
    
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:2];
    item3.selectedImage = [UIImage imageNamed:@"wo_h"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showingLogin) name:@"NotificationOfShowingLogin" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([UserConfigManager shareManager].isLogin) {
        self.selectedIndex = 1;
    }
}

#pragma mark - 
- (void)showingLogin {
//    NSString* userTelStr = [UserConfigManager shareManager].userTelNumStr;
//    if ([userTelStr isKindOfClass:[NSString class]] && 0 != userTelStr.length) {
//        self.selectedIndex = 1;
//    } else {
        [self performSegueWithIdentifier:@"PresentLoginNaviController" sender:self];
//    }
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

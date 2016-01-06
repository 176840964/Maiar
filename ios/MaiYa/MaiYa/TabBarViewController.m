//
//  TabBarViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/12.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "TabBarViewController.h"
#import "LoadingViewController.h"

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
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([UserConfigManager shareManager].isLogin && [UserConfigManager shareManager].isLaunching) {
        self.selectedIndex = 1;
        [UserConfigManager shareManager].isLaunching = NO;
    }
    
    [self showingLodingView];
}

#pragma mark - 
- (void)showingLogin {
    [self performSegueWithIdentifier:@"PresentLoginNaviController" sender:self];
}

- (void)showingLodingView {
    NSString *currentVersion = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSString *recordVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"recordVersion"];
    if (!recordVersion.isValid || ![recordVersion isEqualToString:currentVersion]) {
        [self performSegueWithIdentifier:@"PresentLoadingViewController" sender:self];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PresentLoadingViewController"]  ) {
        LoadingViewController *vc = segue.destinationViewController;
        vc.isFirstLanuching = YES;
    }
}

@end

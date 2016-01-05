//
//  LoadingViewController.m
//  MaiYa
//
//  Created by zxl on 16/1/5.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *closeBtn;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"";
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 480) {
        str = @"4";
    } else if (CGRectGetHeight([UIScreen mainScreen].bounds) == 568) {
        str = @"5";
    } else if (CGRectGetHeight([UIScreen mainScreen].bounds) == 667) {
        str = @"6";
    } else {
        str = @"+";
    }
    
    for (NSInteger index = 0; index < 5; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) * index, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        imageView.image = [UIImage imageNamed:[self stringWithImageNameByIndex:index andDeviceTypeStr:str]];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 5, CGRectGetHeight([UIScreen mainScreen].bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 6 - 46, 26, 46, 26);
    self.closeBtn.cornerRadius = 4.0;
    self.closeBtn.borderWidth = 3;
    self.closeBtn.borderColor = [UIColor whiteColor];
    [self.closeBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(onTapCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBtn];
}

#pragma mark - 
- (NSString *)stringWithImageNameByIndex:(NSInteger)index andDeviceTypeStr:(NSString *)deviceTypeStr{
    NSString *str = @"";
    switch (index) {
        case 0:
            str = [NSString stringWithFormat:@"loading_a%@", deviceTypeStr];
            break;
            
        case 1:
            str = [NSString stringWithFormat:@"loading_b%@", deviceTypeStr];
            break;
            
        case 2:
            str = [NSString stringWithFormat:@"loading_c%@", deviceTypeStr];
            break;
            
        case 3:
            str = [NSString stringWithFormat:@"loading_d%@", deviceTypeStr];
            break;
            
        default:
            str = [NSString stringWithFormat:@"loading_e%@", deviceTypeStr];
            break;
    }
    
    return str;
}

- (void)onTapCloseBtn:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

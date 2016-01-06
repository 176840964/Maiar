//
//  LoadingViewController.m
//  MaiYa
//
//  Created by zxl on 16/1/5.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentSizeWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewsArr;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.closeBtn.cornerRadius = 4.0;
    self.closeBtn.borderWidth = 3;
    self.closeBtn.borderColor = [UIColor whiteColor];
    [self.closeBtn setTitle:@"跳过" forState:UIControlStateNormal];
    
    self.imageViewsArr = [self.imageViewsArr sortByUIViewOriginX];
    
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
        UIImageView *imageView = [self.imageViewsArr objectAtIndex:index];
        imageView.image = [UIImage imageNamed:[self stringWithImageNameByIndex:index andDeviceTypeStr:str]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentSizeWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * self.imageViewsArr.count;
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

#pragma mark - IBAction
- (IBAction)onTapCloseBtn:(UIButton *)btn {
    NSString *currentVersion = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"recordVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end

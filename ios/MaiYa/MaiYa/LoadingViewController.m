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
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (copy, nonatomic) NSString *deviceIdentifier;
@property (assign, nonatomic) CGRect btnFrame;
@property (assign, nonatomic) CGFloat btnLableFont;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.closeBtn.cornerRadius = 4.0;
    self.closeBtn.borderWidth = 3;
    self.closeBtn.borderColor = [UIColor whiteColor];
    [self.closeBtn setTitle:self.isFirstLanuching? @"跳过" : @"关闭" forState:UIControlStateNormal];
    
    NSString *str = @"";
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 480) {
        str = @"4";
        self.btnLableFont = 17;
        self.btnFrame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 130) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 35 - 33, 130, 33);
    } else if (CGRectGetHeight([UIScreen mainScreen].bounds) == 568) {
        str = @"5";
        self.btnLableFont = 17;
        self.btnFrame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 130) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 64 - 33, 130, 33);
    } else if (CGRectGetHeight([UIScreen mainScreen].bounds) == 667) {
        str = @"6";
        self.btnLableFont = 20;
        self.btnFrame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 150) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 75 - 40, 150, 40);
    } else {
        str = @"+";
        self.btnLableFont = 33;
        self.btnFrame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 250) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 74 - 65, 250, 65);
    }
    
    self.deviceIdentifier = str;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 5, CGRectGetHeight([UIScreen mainScreen].bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (NSInteger index = 0; index < 5; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width * index, 0, self.view.width, self.view.height)];
        imageView.image = [UIImage imageNamed:[self stringWithImageNameByIndex:index andDeviceTypeStr:self.deviceIdentifier]];
        [self.scrollView addSubview:imageView];
        
        if (self.isFirstLanuching && index == 4) {
            imageView.userInteractionEnabled = YES;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor colorWithHexString:@"#c53b56"];
            btn.frame = self.btnFrame;
            btn.cornerRadius = CGRectGetHeight(self.btnFrame) / 2.0;
            btn.titleLabel.font = [UIFont systemFontOfSize:self.btnLableFont];
            [btn setTitle:@"立即咨询" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(onTapCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
        }
    }
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

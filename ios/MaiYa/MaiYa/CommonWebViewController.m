//
//  CommonWebViewController.m
//  MaiYa
//
//  Created by zxl on 15/12/25.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommonWebViewController.h"

@interface CommonWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation CommonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  PlazaDetailViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaDetailViewController.h"
#import "ArticleDetailModel.h"

@interface PlazaDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) ArticleDetailViewModel *articleDetailInfo;
@end

@implementation PlazaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *urlStr = [NSString stringWithFormat:@"http://123.56.107.102:33333/?m=home&c=User&a=articleTypeInfo&type=%@&id=%@", self.catIndexStr, self.articleStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
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

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
    
    [self getArticleTypeInfo];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NetWorking
- (void)getArticleTypeInfo {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"articleTypeInfo" params:@{@"type": self.catIndexStr, @"id": self.articleStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *status = [dic objectForKey:@"status"];
        if (![status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            NSString *str = [dic objectForKey:@"error"];
            [[HintView getInstance] presentMessage:str isAutoDismiss:NO dismissBlock:nil];
        } else {
            NSDictionary *resDic = [dic objectForKey:@"res"];
            ArticleDetailModel *model = [[ArticleDetailModel alloc] initWithDic:resDic];
            self.articleDetailInfo = [[ArticleDetailViewModel alloc] initWithArticleDetailModel:model];
        }
    }];
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

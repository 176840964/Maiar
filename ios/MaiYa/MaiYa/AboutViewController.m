//
//  AboutViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/25.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AboutViewController.h"
#import "CommonWebViewController.h"

@interface AboutViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UILabel *nameLab;
@property (nonatomic, weak) IBOutlet UILabel *versionLab;
@property (nonatomic, weak) IBOutlet UITableView *tableview;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [NSBundle mainBundle].infoDictionary);
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    self.nameLab.text = name;
    self.versionLab.text = [NSString stringWithFormat:@"V%@正式版", version];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowBeginnerGuide"]) {
        CommonWebViewController *vc = segue.destinationViewController;
        vc.title = @"新手指南";
        vc.urlStr = [NSString stringWithFormat:@"%@?m=home&c=User&a=noviceHelp", BaseURLString];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"AboutCell%zd", indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1070071969?mt=8"]];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"PresentLoadingViewController" sender:self];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"ShowBeginnerGuide" sender:self];
    }
}

@end

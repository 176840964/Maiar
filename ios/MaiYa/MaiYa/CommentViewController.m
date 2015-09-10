//
//  CommentViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "CommentHeaderView.h"

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CommentHeaderView *headerView = [[CommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 45)];
    [headerView layoutCommentHeaderViewSubviews];
    self.tableView.tableHeaderView = headerView;
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    return cell;
}

@end

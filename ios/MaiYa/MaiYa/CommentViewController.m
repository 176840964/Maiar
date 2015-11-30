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
@property (strong, nonatomic) NSMutableArray *dateArr;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dateArr = [NSMutableArray new];
    
    CommentHeaderView *headerView = [[CommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 45)];
    [headerView layoutCommentHeaderViewSubviewsCountString:self.countStr andAllValueString:self.allValueStr];
    self.tableView.tableHeaderView = headerView;
    
    [self getCommentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)getCommentList {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"commentList" params:@{@"uid": uid} success:^(id responseObject) {
        NSArray *listArr = [[responseObject objectForKey:@"res"] objectForKey:@"list"];
        for (NSDictionary *dic in listArr) {
            CommentModel *model = [[CommentModel alloc] initWithDic:dic];
            CommentViewModel *viewModel = [[CommentViewModel alloc] initWithCommentModel:model];
            [self.dateArr addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    CommentViewModel *viewModel = [self.dateArr objectAtIndex:indexPath.row];
    [cell layoutCommentCellSubviewsByCommentViewModel:viewModel];
    
    return cell;
}

@end

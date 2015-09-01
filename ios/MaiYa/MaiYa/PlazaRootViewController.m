//
//  PlazaRootViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaRootViewController.h"
#import "PlazaWordCell.h"
#import "PlazaCell.h"

@interface PlazaRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PlazaWordCell *commonCell;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *contentStr;
@end

@implementation PlazaRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleStr = @"test";
    self.contentStr = @"迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅迈雅";
    
    [self.tableView registerClass:[PlazaWordCell class] forCellReuseIdentifier:@"PlazaWordCell"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    self.commonCell = [self.tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        PlazaWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlazaWordCell"];
        
        cell.textLab.text = self.contentStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        return cell;
    } else {
        PlazaCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"PlazaCell%zd", indexPath.row]];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        PlazaWordCell *cell = self.commonCell;
        cell.textLab.text = self.contentStr;
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.bounds = CGRectMake(0, 0, self.tableView.width, cell.height);
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        return height + 10;
    } else {
        return 112;
    }
}

@end

//
//  MastersListViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/6.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MastersListViewController.h"
#import "MasterCell.h"
#import "FillterView.h"

@interface MastersListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet FillterView *fillterView;
@property (weak, nonatomic) IBOutlet UIView *markView;
@end

@implementation MastersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
    
    self.btnsArr = [self.btnsArr sortByUIViewOriginX];
    UIButton *btn = [self.btnsArr objectAtIndex:0];
    btn.selected = YES;
    btn.backgroundColor = [UIColor colorWithHexString:@"#7167aa"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)showFillterView {
    if (self.fillterView.hidden) {
        self.fillterView.hidden = NO;
        
        UIButton *btn = [self.btnsArr lastObject];
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#7167aa"];
        
        self.fillterView.height = 0.0;
        [UIView animateWithDuration:.5 animations:^{
            self.fillterView.height = 300;
            self.markView.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)closeFillterView {
    if (!self.fillterView.hidden) {
        UIButton *btn = [self.btnsArr lastObject];
        btn.selected = NO;
        btn.backgroundColor = self.view.backgroundColor;
        
        self.fillterView.hidden = YES;
        self.fillterView.height = 0.0;
        self.markView.alpha = 0.0;
    }
}

#pragma mark - IBAction
- (IBAction)onTapSortBtn:(id)sender {
    UIButton *button = (id)sender;
    if (button.selected && 3 != button.tag) {
        return;
    }
    
    if (3 != button.tag) {
        for (UIButton *btn in self.btnsArr) {
            if (3 == btn.tag) {
                continue;
            }
            btn.selected = NO;
            btn.backgroundColor = self.view.backgroundColor;
        }
    }
    
    
    if (3 == button.tag) {
        if (!self.fillterView.hidden) {
            [self closeFillterView];
        } else {
            [self showFillterView];
        }
    } else {
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#7167aa"];
    }
}

- (IBAction)onTapMarkViewGestureRecognizer:(id)sender {
    [self closeFillterView];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

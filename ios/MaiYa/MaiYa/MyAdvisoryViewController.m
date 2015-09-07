//
//  MyAdvisoryViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyAdvisoryViewController.h"

@interface MyAdvisoryViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *inTableView;
@property (weak, nonatomic) IBOutlet UITableView *finishTableView;
@end

@implementation MyAdvisoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction
- (IBAction)onTapInBtn:(id)sender {
    self.markView.transform = CGAffineTransformIdentity;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)onTapFinishBtn:(id)sender {
    self.markView.transform = CGAffineTransformMakeTranslation(self.markView.width, 0);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.inTableView]) {
        return 20;
    } else {
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.inTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryInCell"];
        return  cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryFinishCell"];
        return  cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"ShowAdvisoryDetailViewController" sender:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollView isEqual:scrollView]) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        if (0 == index) {
            self.markView.transform = CGAffineTransformIdentity;
        } else {
            self.markView.transform = CGAffineTransformMakeTranslation(self.markView.width, 0);
        }
    }
}

@end

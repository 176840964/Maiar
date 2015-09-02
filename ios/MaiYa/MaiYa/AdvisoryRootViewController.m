//
//  AdvisoryRootViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryRootViewController.h"
#import "CarouselCell.h"

@interface AdvisoryRootViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;
@end

@implementation AdvisoryRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CarouselCell *cell = [[CarouselCell alloc] init];
    cell.frame = self.headerScrollView.bounds;
    [self.headerScrollView addSubview:cell];
    
    self.headerScrollView.contentSize = CGSizeMake(self.headerScrollView.width, self.headerScrollView.height);
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.contentHeightConstraint.constant = 687;
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

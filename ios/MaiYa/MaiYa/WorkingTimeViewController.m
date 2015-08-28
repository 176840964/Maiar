//
//  WorkingTimeViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WorkingTimeViewController.h"

@interface WorkingTimeViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labsArr;

@end

@implementation WorkingTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labsArr = [self.labsArr sortByUIViewOriginY];
    
    for (NSInteger index = 0; index < self.labsArr.count; ++index) {
        NSString *str = [self.testArr objectAtIndex:index];
        UILabel *lab = [self.labsArr objectAtIndex:index];
        lab.text = str;
        
        if (3 <= index) {
            [lab alignTop];
        }
    }
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

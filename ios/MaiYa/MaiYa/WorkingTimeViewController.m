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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubviews {
    for (NSInteger index = 0; index < self.labsArr.count; ++index) {
        UILabel *lab = [self.labsArr objectAtIndex:index];
        
        switch (index) {
            case 0:
                lab.text = [self.dataDic objectForKey:@"week"];
                break;
            case 1:
                lab.text = [self.dataDic objectForKey:@"date"];
                break;
            case 2:
                lab.text = [[self.dataDic objectForKey:@"am"] objectForKey:@"title"];
                lab.backgroundColor = [[self.dataDic objectForKey:@"am"] objectForKey:@"bgColor"];
                break;
            case 3:
                lab.text = [[self.dataDic objectForKey:@"pm"] objectForKey:@"title"];
                lab.backgroundColor = [[self.dataDic objectForKey:@"pm"] objectForKey:@"bgColor"];
                break;
            default:
                lab.text = [[self.dataDic objectForKey:@"night"] objectForKey:@"title"];
                lab.backgroundColor = [[self.dataDic objectForKey:@"night"] objectForKey:@"bgColor"];
                break;
        }
        
        if (2 <= index) {
            [lab alignTop];
        }
    }
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

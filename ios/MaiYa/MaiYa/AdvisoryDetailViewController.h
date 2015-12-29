//
//  AdvisoryDetailViewController.h
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAdvisoryViewController.h"

@interface AdvisoryDetailViewController : BaseViewController
@property (weak, nonatomic) MyAdvisoryViewController *parentController;
@property (copy, nonatomic) NSString *orderIdStr;

@end

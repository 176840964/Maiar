//
//  MyZoneViewController.h
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ZoneViewControllerType) {
    ZoneViewControllerTypeOfMine,
    ZoneViewControllerTypeOfOther,
};

@interface MyZoneViewController : BaseViewController

@property (assign, nonatomic) ZoneViewControllerType type;
@property (copy, nonatomic) NSString *cidStr;
@property (copy, nonatomic) NSString *oidStr;

@end

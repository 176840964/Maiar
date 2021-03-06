//
//  BankCityViewController.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCell.h"

typedef void(^DidSelectedAreaHandle)(AreaViewModel *);

@interface BankCityViewController : BaseViewController

@property (copy, nonatomic) DidSelectedAreaHandle didSelectedHandle;
@property (copy, nonatomic) NSString *selectedAreaIdStr;

@end

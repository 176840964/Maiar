//
//  BankViewController.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCell.h"

typedef void(^DidSelectedBandHandle)(BankViewModel *);

@interface BankViewController : BaseViewController

@property (copy, nonatomic) DidSelectedBandHandle didSelectedHandle;
@property (copy, nonatomic) NSString *selectedBackIdStr;

@end

//
//  AdvisoryDetailPayCell0.h
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryDetailPayCell0 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *useCouponStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;
@property (weak, nonatomic) IBOutlet UISwitch *useBalanceSwitch;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLab;

@property (copy, nonatomic) TapViewHandler tapCommitBtnHandle;

@end

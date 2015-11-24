//
//  CouponCell.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponsModel.h"

@interface CouponCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;

- (void)layoutCouponCellSubviewsByCouponsViewModel:(CouponsViewModel *)viewModel;

@end

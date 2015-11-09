//
//  MyAdvisoryCell.h
//  MaiYa
//
//  Created by zxl on 15/11/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface MyAdvisoryCell : UITableViewCell

- (void)layoutMyAdvisorySubviewsByOrderViewModel:(OrderViewModel *)viewModel;

@end

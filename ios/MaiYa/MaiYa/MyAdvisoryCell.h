//
//  MyAdvisoryCell.h
//  MaiYa
//
//  Created by zxl on 15/11/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

typedef void(^tapBtnHandler)(NSString *btnTitleStr);

@interface MyAdvisoryCell : UITableViewCell

@property (copy, nonatomic) tapBtnHandler tapBtnHandler;

- (void)layoutMyAdvisorySubviewsByOrderViewModel:(OrderViewModel *)viewModel;

@end

//
//  WorkingDateView.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapSelectedDateHandle)(NSNumber *indexNum);

@interface WorkingDateView : UIView

@property (copy, nonatomic) TapSelectedDateHandle selectedDateHandle;

- (void)layoutWorkingDateViewSubviewsByDateArr:(NSArray *)arr;

@end

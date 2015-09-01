//
//  PlazaCell.h
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBtnHandle)(NSNumber *);

@interface PlazaCell : UITableViewCell

@property (copy, nonatomic) TapBtnHandle tapBtnHandler;

- (void)layoutPlazaCellSubviewsByArr:(NSArray *)arr;

@end

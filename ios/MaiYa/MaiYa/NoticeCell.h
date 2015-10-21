//
//  NoticeCell.h
//  MaiYa
//
//  Created by zxl on 15/8/25.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface NoticeCell : UITableViewCell
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *contentLab;

- (void)layoutNoticCellSubviewsByMessageViewModel:(MessageViewModel *)viewModel;
@end

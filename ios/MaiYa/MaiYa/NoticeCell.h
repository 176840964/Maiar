//
//  NoticeCell.h
//  MaiYa
//
//  Created by zxl on 15/8/25.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;

- (void)layoutNoticCellSubviewsByDic:(NSDictionary*)dic;
@end

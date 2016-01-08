//
//  TimeCollectionViewCell.m
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "TimeCollectionViewCell.h"

@interface TimeCollectionViewCell ()
@end

@implementation TimeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeLab = [[UILabel alloc] init];
        self.timeLab.textColor = [UIColor whiteColor];
        self.timeLab.font = [UIFont systemFontOfSize:10];
        self.timeLab.backgroundColor = [UIColor lightGrayColor];
        self.timeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.timeLab];
    }
    return self;
}
@end

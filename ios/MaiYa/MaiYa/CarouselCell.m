//
//  HeaderCell.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CarouselCell.h"

@implementation CarouselCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultCarousel"]];
        [self addSubview:self.imageView];
        
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    }
    return self;
}

@end

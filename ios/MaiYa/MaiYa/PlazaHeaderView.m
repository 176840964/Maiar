//
//  PlazaHeaderView.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaHeaderView.h"
#import "CarouselCell.h"

@implementation PlazaHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        CarouselCell *cell = [[CarouselCell alloc] init];
        cell.frame = self.bounds;
        [self addSubview:cell];
        
        self.contentSize = CGSizeMake(self.width, self.height);
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

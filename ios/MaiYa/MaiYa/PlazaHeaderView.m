//
//  PlazaHeaderView.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaHeaderView.h"
#import "CarouselCell.h"
#import "ArticleModel.h"

@implementation PlazaHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
    }
    
    return self;
}

- (void)layoutPlazeHeaderViewSubviewsByArr:(NSArray *)arr {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CarouselCell class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger index = 0; index < arr.count; ++index) {
        ArticleViewModel *viewModel = [arr objectAtIndex:index];
        
        CarouselCell *cell = [[CarouselCell alloc] init];
        cell.tag = index;
        cell.url = viewModel.url;
        cell.titleStr = viewModel.titleStr;
        cell.frame = CGRectMake(index * self.width, 0, self.width, self.height);
        [cell.imageView setImageWithURL:viewModel.imgUrl placeholderImage:[UIImage imageNamed:@"testHeader"]];
        [cell addTarget:self action:@selector(onTapCell:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cell];
    }
    
    self.contentSize = CGSizeMake(self.width * arr.count, self.height);
}

#pragma mark - 
- (void)onTapCell:(CarouselCell *)cell {
    if (self.tapHeaderViewHandle) {
        self.tapHeaderViewHandle(cell.url, cell.titleStr);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

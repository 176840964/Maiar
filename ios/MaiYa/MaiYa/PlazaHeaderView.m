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
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 13 - 10, CGRectGetWidth(frame), 13)];
        [_pageControl addTarget:self action:@selector(onTapPageControl:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
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
        [cell.imageView setImageWithURL:viewModel.imgUrl placeholderImage:[UIImage imageNamed:@"defaultCarousel"]];
        [cell addTarget:self action:@selector(onTapCell:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:cell];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.width * arr.count, self.height);
    self.pageControl.numberOfPages = arr.count;
}

#pragma mark - 
- (void)onTapCell:(CarouselCell *)cell {
    if (self.tapHeaderViewHandle) {
        self.tapHeaderViewHandle(cell.url, cell.titleStr);
    }
}

- (void)onTapPageControl:(UIPageControl*)pageCtrl {
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame) * pageCtrl.currentPage, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

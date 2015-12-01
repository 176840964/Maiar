//
//  RefreshDropdownView.m
//  quanminzhekou
//
//  Created by zxl on 15/1/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "RefreshDropdownView.h"

@implementation RefreshDropdownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_dropdown"]];
        [self addSubview:_imageView];
        
        _desLab = [[UILabel alloc] init];
        _desLab.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _desLab.backgroundColor = [UIColor clearColor];
        _desLab.font = [UIFont systemFontOfSize:12];
        _desLab.textColor = [UIColor colorWithRed:0x5d / 255.0 green:0x5d / 255.0 blue:0x5d / 255.0 alpha:1.0];
        [self addSubview:_desLab];
        
        self.statue = RefreshDropdownDroping;
    }
    
    return self;
}

- (void)setStatue:(RefreshDropdownStatue)statue {
    _statue = statue;
    
    switch (statue) {
        case RefreshDropdownDroping:
            _desLab.text = @"用力下拉，可以刷新哦~";
            break;
        case RefreshDropdownNormal:
            _desLab.text = @"该放手啦，我要去刷新了~";
            break;
        case RefreshDropdownLoading:
            _desLab.text = @"努力加载中~";
            break;
        default:
            break;
    }
    
    _desLab.frame = [self.desLab textRectForBounds:self.bounds limitedToNumberOfLines:0];
    _desLab.center = CGPointMake(self.center.x, -self.center.y);
    
    _imageView.frame = CGRectMake(CGRectGetMinX(_desLab.frame) - 15 - 2, CGRectGetMinY(_desLab.frame), 15, 15);
}

- (void)refreshScrollViewDidScroll:(UIScrollView*)scrollView {
    if (self.statue == RefreshDropdownLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 50);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    } else if (scrollView.isDragging) {
        BOOL loading = NO;
        if ([self.delegate respondsToSelector:@selector(refreshDropdownViewDataSourceIsLoading:)]) {
            loading = [self.delegate refreshDropdownViewDataSourceIsLoading:self];
        }
        
        if (self.statue == RefreshDropdownNormal && scrollView.contentOffset.y > -50 && scrollView.contentOffset.y < 0.0 && !loading) {
            [self setStatue:RefreshDropdownDroping];
        } else if (self.statue == RefreshDropdownDroping && scrollView.contentOffset.y < -50 && !loading) {
            [self setStatue:RefreshDropdownNormal];
        }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView*)scrollView {
    BOOL loading = NO;
    if ([self.delegate respondsToSelector:@selector(refreshDropdownViewDataSourceIsLoading:)]) {
        loading = [self.delegate refreshDropdownViewDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y <= -50 && !loading) {
        
        if ([self.delegate respondsToSelector:@selector(refreshDropdownViewDidTriggerRefresh:)]) {
            [self.delegate refreshDropdownViewDidTriggerRefresh:self];
        }
        
        [self setStatue:RefreshDropdownLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
        
    }
}

- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView*)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
    
    [self setStatue:RefreshDropdownNormal];
}


@end

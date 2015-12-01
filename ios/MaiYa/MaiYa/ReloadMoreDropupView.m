//
//  ReloadMoreDropupView.m
//  quanminzhekou
//
//  Created by zxl on 15/1/22.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "ReloadMoreDropupView.h"

@implementation ReloadMoreDropupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _desLab = [[UILabel alloc] init];
        _desLab.backgroundColor = [UIColor clearColor];
        _desLab.font = [UIFont systemFontOfSize:12];
        _desLab.textColor = [UIColor colorWithRed:0x5d / 255.0 green:0x5d / 255.0 blue:0x5d / 255.0 alpha:1.0];
        [self addSubview:_desLab];
        
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        _activityView.frame = CGRectMake(0, 0, 15, 15);
//        _activityView.hidden = YES;
//        [self addSubview:_activityView];
        
        self.statue = ReloadMoreDropupDroping;
    }
    
    return self;
}

- (UIActivityIndicatorView*)activityView {
    if (nil == _activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(0, 0, 15, 15);
        _activityView.hidden = YES;
        [self addSubview:_activityView];
    }
    
    return _activityView;
}

- (void)setStatue:(ReloadMoreDropupViewStatue)statue {
    _statue = statue;
    
    switch (statue) {
        case ReloadMoreDropupDroping:
            _desLab.text = @"用力上拉，可以加载更多哦~";
            self.activityView.hidden = YES;
            break;
        case ReloadMoreDropupLoading:
            _desLab.text = @"努力加载中...";
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
            break;
        case ReloadMoreDropupEnd:
            _desLab.text = @"没有更多数据了~";
            [self.activityView removeFromSuperview];
            _activityView = nil;
            break;
        default:
            break;
    }
    
    _desLab.frame = [self.desLab textRectForBounds:self.bounds limitedToNumberOfLines:0];
    _desLab.center = CGPointMake(self.center.x, 22);
    
    _activityView.frame = CGRectMake(CGRectGetMinX(_desLab.frame) - 15 - 5, CGRectGetMinY(_desLab.frame), 15, 15);
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if (ReloadMoreDropupLoading == self.statue) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    } else if (ReloadMoreDropupEnd == self.statue) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    } else {
        if (scrollView.contentOffset.y + CGRectGetHeight(scrollView.bounds) > scrollView.contentSize.height + 50) {
            self.statue = ReloadMoreDropupLoading;
            
            if ([self.delegate respondsToSelector:@selector(reloadMoreDropupViewWillReloadData:)]) {
                [self.delegate reloadMoreDropupViewWillReloadData:self];
            }
        }
    }
}

- (void)didFinishedReloadWithScrollView:(UIScrollView*)scrollView {
    if (ReloadMoreDropupEnd == self.statue) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    } else {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

@end

//
//  CustomTableView.m
//  MaiYa
//
//  Created by zxl on 15/12/1.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "CustomTableView.h"

@interface CustomTableView ()

@property (assign, nonatomic) BOOL isCanRefresh;
@property (assign, nonatomic) BOOL isCanReloadMore;
@property (assign, nonatomic) BOOL isRefreshLoading;

@end

@implementation CustomTableView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (void)setIsCanRefresh:(BOOL)isCanRefresh {
    _isCanRefresh = isCanRefresh;
    
    if (_isCanRefresh) {
        if (nil == _refreshView) {
            _refreshView = [[RefreshDropdownView alloc] initWithFrame:CGRectMake(0, -44, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
            _refreshView.backgroundColor = [UIColor clearColor];
            _refreshView.delegate = self;
            [self addSubview:_refreshView];
        }
    } else {
        [_refreshView removeFromSuperview];
        _refreshView.delegate = nil;
        _refreshView = nil;
    }
}

- (void)setIsCanReloadMore:(BOOL)isCanReloadMore {
    _isCanReloadMore = isCanReloadMore;
    
    if (_isCanReloadMore) {
        if (nil == _reloadMoreView) {
            _reloadMoreView = [[ReloadMoreDropupView alloc] initWithFrame:CGRectMake(0, self.contentSize.height + (self.bounds.size.height - MIN(self.bounds.size.height, self.contentSize.height)), CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
            _reloadMoreView.backgroundColor = [UIColor clearColor];
            _reloadMoreView.delegate = self;
            [self addSubview:_reloadMoreView];
        }
    } else {
        [_reloadMoreView removeFromSuperview];
        _reloadMoreView.delegate = nil;
        _reloadMoreView = nil;
    }
}

- (void)setUpSubviewsIsCanRefresh:(BOOL)isCanRefresh andIsCanReloadMore:(BOOL)isCanReloadMore {
    self.startOffsetStr = @"0";
    self.type = CustomTableViewUpdateTypeNone;
    self.isCanRefresh = isCanRefresh;
    self.isCanReloadMore = isCanReloadMore;
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)finishRefreshData {
    self.type = CustomTableViewUpdateTypeNone;
    self.isRefreshLoading = NO;
    [self.refreshView refreshScrollViewDataSourceDidFinishedLoading:self];
    self.reloadMoreView.statue = ReloadMoreDropupDroping;
}

- (void)finishReloadMoreDataWithIsEnd:(BOOL)isEnd {
    self.type = CustomTableViewUpdateTypeNone;
    if (isEnd) {
        self.reloadMoreView.statue = ReloadMoreDropupEnd;
    } else {
        self.reloadMoreView.statue = ReloadMoreDropupDroping;
    }
    [self.reloadMoreView didFinishedReloadWithScrollView:self];
}

#pragma mark -
- (void)resetReloadMoreViewFrame {
    _reloadMoreView.frame = CGRectMake(0, self.contentSize.height + (self.bounds.size.height - MIN(self.bounds.size.height, self.contentSize.height)), CGRectGetWidth([UIScreen mainScreen].bounds), 44);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        [self resetReloadMoreViewFrame];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshView refreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshView refreshScrollViewDidScroll:scrollView];
    [self.reloadMoreView scrollViewDidScroll:scrollView];
}

#pragma mark - RefreshDropdownViewDelegate
- (void)refreshDropdownViewDidTriggerRefresh:(RefreshDropdownView*)refreshDropdownView {
    self.type = CustomTableViewUpdateTypeRefresh;
    self.isRefreshLoading = YES;
    
    if ([self.customDelegate respondsToSelector:@selector(customTableViewRefresh:)]) {
        [self.customDelegate customTableViewRefresh:self];
    }
}

- (BOOL)refreshDropdownViewDataSourceIsLoading:(RefreshDropdownView*)refreshDropdownView {
    return self.isRefreshLoading;
}

#pragma mark - ReloadMoreDropupViewDelegate
- (void)reloadMoreDropupViewWillReloadData:(ReloadMoreDropupView *)reloadMoreDropupView {
    self.type = CustomTableViewUpdateTypeReloadMore;
    
    if ([self.customDelegate respondsToSelector:@selector(customTableViewReloadMore:)]) {
        [self.customDelegate customTableViewReloadMore:self];
    }
}

@end

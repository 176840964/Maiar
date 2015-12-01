//
//  ReloadMoreDropupView.h
//  quanminzhekou
//
//  Created by zxl on 15/1/22.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ReloadMoreDropupViewStatue) {
    ReloadMoreDropupDroping,
    ReloadMoreDropupLoading,
    ReloadMoreDropupEnd,
};

@protocol ReloadMoreDropupViewDelegate;

@interface ReloadMoreDropupView : UIView

@property (nonatomic, strong) UILabel* desLab;
@property (nonatomic, strong) UIActivityIndicatorView* activityView;

@property (nonatomic, assign) ReloadMoreDropupViewStatue statue;

@property (nonatomic, weak) id<ReloadMoreDropupViewDelegate> delegate;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
- (void)didFinishedReloadWithScrollView:(UIScrollView*)scrollView;

@end

@protocol ReloadMoreDropupViewDelegate <NSObject>

- (void)reloadMoreDropupViewWillReloadData:(ReloadMoreDropupView*)reloadMoreDropupView;

@end

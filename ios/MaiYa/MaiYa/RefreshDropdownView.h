//
//  RefreshDropdownView.h
//  quanminzhekou
//
//  Created by zxl on 15/1/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RefreshDropdownStatue) {
    RefreshDropdownDroping,
    RefreshDropdownNormal,
    RefreshDropdownLoading,
};

@protocol RefreshDropdownViewDelegate;

@interface RefreshDropdownView : UIView

@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel*  desLab;
@property (nonatomic, assign) RefreshDropdownStatue statue;

@property (nonatomic, weak) id<RefreshDropdownViewDelegate> delegate;

- (void)refreshScrollViewDidScroll:(UIScrollView*)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView*)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView*)scrollView;

@end

@protocol RefreshDropdownViewDelegate <NSObject>

@optional
- (void)refreshDropdownViewDidTriggerRefresh:(RefreshDropdownView*)refreshDropdownView;
- (BOOL)refreshDropdownViewDataSourceIsLoading:(RefreshDropdownView*)refreshDropdownView;

@end

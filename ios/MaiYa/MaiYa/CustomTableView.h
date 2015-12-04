//
//  CustomTableView.h
//  MaiYa
//
//  Created by zxl on 15/12/1.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshDropdownView.h"
#import "ReloadMoreDropupView.h"

@protocol CustomTableViewViewDelegate;

typedef NS_ENUM(NSInteger, CustomTableViewUpdateType) {
    CustomTableViewUpdateTypeNone,
    CustomTableViewUpdateTypeRefresh,
    CustomTableViewUpdateTypeReloadMore,
};

@interface CustomTableView : UITableView <RefreshDropdownViewDelegate, ReloadMoreDropupViewDelegate, UIScrollViewDelegate>

@property (assign, nonatomic) CustomTableViewUpdateType type;
@property (weak, nonatomic) id<CustomTableViewViewDelegate> customDelegate;

@property (strong, nonatomic) RefreshDropdownView *refreshView;
@property (strong, nonatomic) ReloadMoreDropupView* reloadMoreView;

- (void)setUpSubviewsIsCanRefresh:(BOOL)isCanRefresh andIsCanReloadMore:(BOOL)isCanReloadMore;

//恢复默认状态
- (void)finishRefreshData;
- (void)finishReloadMoreDataWithIsEnd:(BOOL)isEnd;

@end

@protocol CustomTableViewViewDelegate <NSObject>

@optional
- (void)customTableViewRefresh:(CustomTableView*)customTableView;
- (void)customTableViewReloadMore:(CustomTableView*)customTableView;

@end
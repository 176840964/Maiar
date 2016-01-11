//
//  PlazaHeaderView.h
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapHeaderViewHandle)(NSURL *url, NSString *titleStr);

@interface PlazaHeaderView : UIView
@property (copy, nonatomic) TapHeaderViewHandle tapHeaderViewHandle;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

- (void)layoutPlazeHeaderViewSubviewsByArr:(NSArray *)arr;
@end

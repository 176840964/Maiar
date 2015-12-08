//
//  PlazaHeaderView.h
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapHeaderViewHandle)(NSURL *);

@interface PlazaHeaderView : UIScrollView
@property (copy, nonatomic) TapHeaderViewHandle tapHeaderViewHandle;

- (void)layoutPlazeHeaderViewSubviewsByArr:(NSArray *)arr;
@end

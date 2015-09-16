//
//  MeHeaderView.h
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MeHeaderType) {
    MeHeaderTypeOfLogin,
    MeHeaderTypeOfLogout,
};

@interface MeHeaderView : UIView
@property (nonatomic, copy) TapViewHandler tapUserHeadPortraitHandler;
@property (nonatomic, assign) MeHeaderType type;
@end

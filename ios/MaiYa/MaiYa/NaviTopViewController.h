//
//  NaviTopViewController.h
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviTopViewController : UIViewController
@property (nonatomic, copy) NSString *backBtnTitle;
@property (nonatomic, copy) NSString *titleLabStr;
@property (nonatomic, copy) NSString *rightBtnImgStr;
@property (nonatomic, copy) NSString *rightSecondBtnImgStr;

@property (nonatomic, copy) TapViewHandler tapBackBtnHandler;
@property (nonatomic, copy) TapViewHandler tapRightBtnHandler;
@property (nonatomic, copy) TapViewHandler tapRightSecondBtnHandler;

@end

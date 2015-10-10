//
//  BaseViewController.h
//  MaiYa
//
//  Created by zxl on 15/8/19.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, copy) NSString *backBtnTitle;
@property (nonatomic, copy) NSString *titleLabStr;
@property (nonatomic, copy) NSString *rightBtnImgStr;
@property (nonatomic, copy) NSString *rightSecondBtnImgStr;
@property (nonatomic, copy) TapViewHandler tapNaviRightBtnHandler;
@property (nonatomic, copy) TapViewHandler tapNaviRightSecondBtnHandler;

@end

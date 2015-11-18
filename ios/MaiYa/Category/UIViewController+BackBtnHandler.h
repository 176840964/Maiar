//
//  UIViewController+BackBtnHandler.h
//  MaiYa
//
//  Created by zxl on 15/11/18.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackBtnHandlerProtocol <NSObject>

@optional
-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackBtnHandler) <BackBtnHandlerProtocol>

@end

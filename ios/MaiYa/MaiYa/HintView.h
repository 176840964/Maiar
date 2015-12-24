//
//  HintView.h
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HintView : UIWindow

+ (instancetype)getInstance;
- (void)presentMessage:(NSString *)message isAutoDismiss:(BOOL)isAuto dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^)(void))dismissBlock;
- (void)dismissMessage;

@end

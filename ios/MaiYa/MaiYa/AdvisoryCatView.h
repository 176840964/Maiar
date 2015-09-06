//
//  AdvisoryCatView.h
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AdvisoryCatModel) {
    AdvisoryCatModelZhanxing = 0,
    AdvisoryCatModelTaluo = 1,
    AdvisoryCatModelZhouyi = 2,
    AdvisoryCatModelNone = 3,
};

typedef void(^TapAdvisoryCatHandler)(NSNumber *catModel);

@interface AdvisoryCatView : UIWindow

@property (assign, nonatomic) AdvisoryCatModel catModel;
@property (copy, nonatomic) TapAdvisoryCatHandler selectedAdvisoryCatHandler;

- (void)show;

@end

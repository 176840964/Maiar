//
//  AdvisoryDetailViewController.h
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, AdvisoryDetailType){
    AdvisoryDetailTypeOfGoingOn,//进行中
    AdvisoryDetailTypeOfNoComment,//已完成，未评论
    AdvisoryDetailTypeOfFinish,//已完成，已评论
    AdvisoryDetailTypeOfOrdering,//下单状态
    AdvisoryDetailTypeOfNonPayment,//未付款状态
    AdvisoryDetailTypeOfAll,//test 所有cell
};

@interface AdvisoryDetailViewController : BaseViewController
@property (nonatomic, assign) AdvisoryDetailType type;

@end

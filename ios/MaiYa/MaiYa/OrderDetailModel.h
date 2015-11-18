//
//  OrderDetailModel.h
//  MaiYa
//
//  Created by zxl on 15/11/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"
#import "UserZoneModel.h"
#import "CommentModel.h"
#import "CreateOrderViewModel.h"

typedef NS_ENUM(NSInteger, OrderDetailType){
    OrderDetailTypeOfGoingOn,//进行中
    OrderDetailTypeOfNoComment,//已完成，未评论
    OrderDetailTypeOfFinish,//已完成，已评论
    OrderDetailTypeOfOrdering,//下单状态
    OrderDetailTypeOfNonPayment,//未付款状态
    OrderDetailTypeOfAll,//test 所有cell
};

@interface OrderDetailModel : BaseModel
@property (copy, nonatomic) NSString *orderid;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *problem;
@property (copy, nonatomic) NSString *consulting_time;
@property (copy, nonatomic) NSString *order_type;
@property (copy, nonatomic) NSString *service_mode;
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *money_all;
@property (copy, nonatomic) NSString *coupons_money;
@property (copy, nonatomic) NSString *money_balance;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *consultant;
@property (strong, nonatomic) NSDictionary *comment;
@property (strong, nonatomic) NSDictionary *userinfo;
@end

@interface OrderDetailViewModel : NSObject
@property (copy, nonatomic) NSString *orderIdStr;
@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *cidStr;
@property (copy, nonatomic) NSString *problemStr;
@property (copy, nonatomic) NSString *orderTypeStr;
@property (copy, nonatomic) NSString *serviceModeStr;
@property (copy, nonatomic) NSString *moneyStr;
@property (copy, nonatomic) NSString *moneyAllStr;
@property (copy, nonatomic) NSString *timeStr;

@property (copy, nonatomic) NSString *nonPayMoneyAllStr;
@property (copy, nonatomic) NSString *nonPayMoneyCouponStr;
@property (copy, nonatomic) NSString *nonPayMoneyBalanceStr;
@property (strong, nonatomic) NSMutableAttributedString *nonPayMoneyStr;

@property (strong, nonatomic) NSArray *consultingTimeArr;

@property (assign, nonatomic) NSInteger cellCountByStatus;
@property (assign, nonatomic) OrderDetailType orderDetailType;
@property (strong, nonatomic) NSMutableArray *identifiersArr;

@property (assign, nonatomic) BOOL isConsultant;
@property (strong, nonatomic) CommentViewModel *commentViewModel;

@property (strong, nonatomic) UserZoneViewModel *userInfoViewModel;
@property (copy, nonatomic) NSString *balanceStr;

- (instancetype)initWithOrderDetailModel:(OrderDetailModel *)model;
- (instancetype)initWithCreateOrderViewModel:(CreateOrderViewModel *)viewModel;

@end
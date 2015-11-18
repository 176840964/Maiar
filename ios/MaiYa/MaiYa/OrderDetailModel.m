//
//  OrderDetailModel.m
//  MaiYa
//
//  Created by zxl on 15/11/9.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "OrderDetailModel.h"
#import "OrderDateModel.h"

@implementation OrderDetailModel

@end

@implementation OrderDetailViewModel

- (instancetype)initWithOrderDetailModel:(OrderDetailModel *)model {
    if (self = [super init]) {
        self.orderIdStr = [NSString stringWithFormat:@"订单号：%@", model.orderid];
        self.uidStr = model.uid;
        self.cidStr = model.cid;
        self.problemStr = [NSString stringWithFormat:@"咨询问题：%@", model.problem];
        self.orderTypeStr = model.order_type;
        self.serviceModeStr = [model.order_type isEqualToString:@"1"] ? @"线上" : @"线下";
        self.moneyStr = [NSString stringWithFormat:@"￥%.2zd", model.money.integerValue];
        self.moneyAllStr = [NSString stringWithFormat:@"￥%.2zd", model.money_all.integerValue];
        
        self.nonPayMoneyAllStr = [NSString stringWithFormat:@"￥%.2f", model.money_all.doubleValue / 100];
        self.nonPayMoneyCouponStr = [NSString stringWithFormat:@"￥-%.2f", model.coupons_money.doubleValue / 100];
        self.nonPayMoneyBalanceStr = [NSString stringWithFormat:@"￥-%.2f", model.money_balance.doubleValue / 100];
        
        NSString *nonPayMoney = [NSString stringWithFormat:@"实付款：￥%.2f", model.money.doubleValue / 100];
        self.nonPayMoneyStr = [[NSMutableAttributedString alloc] initWithString:nonPayMoney];
        [self.nonPayMoneyStr addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:25], NSForegroundColorAttributeName : [UIColor colorWithR:135 g:144 b:155]} range:NSMakeRange(0, 4)];
        [self.nonPayMoneyStr addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:25], NSForegroundColorAttributeName : [UIColor colorWithR:248 g:142 b:9]} range:NSMakeRange(4, nonPayMoney.length - 4)];
        
        [self setupCellsCountByStatusString:model.status];
        self.isConsultant = [model.consultant isEqualToString:@"1"];
        
        NSString *time = [CustomTools dateStringFromUnixTimestamp:model.ctime.integerValue withFormatString:@"yyyy-MM-dd hh:mm:ss"];
        self.timeStr = [NSString stringWithFormat:@"下单时间：%@", time];
        
        NSMutableArray *consultingTimeArr = [NSMutableArray new];
        NSArray *arr = [model.consulting_time componentsSeparatedByString:@"|"];
        for (NSString *str in arr) {
            OrderDateModel *dateModel = [[OrderDateModel alloc] initWithDateString:str];
            [consultingTimeArr addObject:dateModel];
        }
        self.consultingTimeArr = [NSArray arrayWithArray:consultingTimeArr];
        
        if (model.comment && ![model.comment isEqual:[NSNull null]]) {
            CommentModel *commentModel = [[CommentModel alloc] initWithDic:model.comment];
            self.commentViewModel = [[CommentViewModel alloc] initWithCommentModel:commentModel];
        }
        
        UserZoneModel *zoneModel = [[UserZoneModel alloc] initWithDic:model.userinfo];
        self.userInfoViewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:zoneModel];
    }
    
    return self;
}

- (instancetype)initWithCreateOrderViewModel:(CreateOrderViewModel *)viewModel {
    if (self = [super init]) {
        self.uidStr = viewModel.userInfo.uid;
        self.cidStr = viewModel.masterInfo.uid;
        self.userInfoViewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:viewModel.masterInfo];
        self.problemStr = [NSString stringWithFormat:@"咨询问题：%@", viewModel.problemStr];
        self.orderTypeStr = @"1";
        self.serviceModeStr = [viewModel.servieceModelStr isEqualToString:@"1"] ? @"线上" : @"线下";
        self.cellCountByStatus = 5;
        self.orderDetailType = OrderDetailTypeOfOrdering;
        
        NSInteger balance = viewModel.userInfo.balance.integerValue;
        self.balanceStr = [NSString stringWithFormat:@"可用余额￥%zd元", balance / 100];
        
        NSArray *allKeys = viewModel.timeDic.allKeys;
        allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return (obj1.integerValue < obj2.integerValue) ? NSOrderedAscending : (obj1.integerValue > obj2.integerValue) ? NSOrderedDescending : NSOrderedSame;
        }];
        
        NSInteger hourCount = 0;
        NSMutableArray *consultingTimeArr = [NSMutableArray new];
        for (NSString *key in allKeys) {
            NSArray *arr = [viewModel.timeDic objectForKey:key];
            OrderDateModel *model = [[OrderDateModel alloc] initWithTimestamp:key andHourArr:arr];
            [consultingTimeArr addObject:model];
            hourCount += arr.count;
        }
        self.consultingTimeArr = [NSArray arrayWithArray:consultingTimeArr];
        
        self.moneyAllStr = [NSString stringWithFormat:@"共%zd小时，总金额￥%zd元", hourCount, viewModel.masterInfo.hour_money.integerValue / 100 * hourCount];
        
        [UserConfigManager shareManager].createOrderViewModel.totalTimeStr = [NSString stringWithFormat:@"%zd", hourCount];
        [UserConfigManager shareManager].createOrderViewModel.moneyAllStr = [NSString stringWithFormat:@"%zd", viewModel.masterInfo.hour_money.integerValue * hourCount];
        [UserConfigManager shareManager].createOrderViewModel.moneyStr = [UserConfigManager shareManager].createOrderViewModel.moneyAllStr;
        [UserConfigManager shareManager].createOrderViewModel.isUsingBalance = NO;
    }
    
    return self;
}

- (void)setupCellsCountByStatusString:(NSString *)statusStr {
    if ([statusStr isEqualToString:@"10"]) {
        self.cellCountByStatus = 6;
        self.orderDetailType = OrderDetailTypeOfNonPayment;
    } else if ([statusStr isEqualToString:@"11"]) {
        self.cellCountByStatus = 5;
        self.orderDetailType = OrderDetailTypeOfGoingOn;
    } else if ([statusStr isEqualToString:@"12"]) {
        self.cellCountByStatus = 5;
        self.orderDetailType = OrderDetailTypeOfGoingOn;
    } else if ([statusStr isEqualToString:@"13"]) {
        self.cellCountByStatus = 6;
        self.orderDetailType = OrderDetailTypeOfNoComment;
    } else if ([statusStr isEqualToString:@"14"]) {
        self.cellCountByStatus = 6;
        self.orderDetailType = OrderDetailTypeOfFinish;
    } else {
        self.cellCountByStatus = 10;
        self.orderDetailType = OrderDetailTypeOfAll;
    }
}

- (void)setOrderDetailType:(OrderDetailType)orderDetailType {
    _orderDetailType = orderDetailType;
    
    self.identifiersArr = [NSMutableArray new];
    
    switch (_orderDetailType) {
        case OrderDetailTypeOfNonPayment:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell1"];
        }
            break;
            
        case OrderDetailTypeOfGoingOn:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:self.isConsultant? @"AdvisoryDetailUserCell" : @"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
        }
            break;
            
        case OrderDetailTypeOfNoComment:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:self.isConsultant? @"AdvisoryDetailUserCell" : @"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailCommentCell"];
        }
            break;
            
        case OrderDetailTypeOfFinish:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:self.isConsultant? @"AdvisoryDetailUserCell" : @"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailEndCell"];
        }
            break;
            
        case OrderDetailTypeOfOrdering:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell0"];
        }
            break;
            
        default:{
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailUserCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailCommentCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailEndCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell0"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell1"];
        }
    }
}

@end

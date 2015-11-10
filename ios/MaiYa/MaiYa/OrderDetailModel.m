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
        self.moneyStr = model.money;
        self.moneyAllStr = model.money_all;
        self.timeStr = model.ctime;
        [self setupCellsCountByStatusString:model.status];
        self.isConsultant = [model.consultant isEqualToString:@"1"];
        
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

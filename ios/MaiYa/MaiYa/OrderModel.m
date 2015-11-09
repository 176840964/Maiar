//
//  OrderModel.m
//  MaiYa
//
//  Created by zxl on 15/11/5.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

@end

@interface OrderViewModel ()
@property (assign, nonatomic) BOOL isReservation;
@end

@implementation OrderViewModel

- (instancetype)initWithOrderModel:(OrderModel *)model {
    self = [super init];
    if (self) {
        self.orderIdStr = model.orderid;
        self.uidStr = model.uid;
        self.cidStr = model.cid;
        
        self.timeStr = [CustomTools dateStringFromUnixTimestamp:model.ctime.integerValue withFormatString:@"MM年dd月(ww) hh:mm"];
        [self getStatusStrByModelStatus:model.status];
        self.starStr = [model.star stringValue];
        
        self.isConsultant = [model.consultant isEqualToString:@"1"];
        self.nameTitleStr = self.isConsultant ? @"咨询师:" : @"用户:";
        self.nameStr = model.cname;
        self.telStr = model.username;
        self.problemStr = model.problem;
        
        self.isReservation = [model.order_type isEqualToString:@"1"];
        self.totalStr = [NSString stringWithFormat:@"总计%@小时(%@)", model.total, self.isReservation ? @"预约" : @"即时咨询"];
        
        self.serviceModeStr = [model.order_type isEqualToString:@"1"] ? @"线上" : @"线下";
        
        self.realPriceStr = model.money;
        self.totalPriceStr = [NSString stringWithFormat:@"￥%.2f元", model.money_all.integerValue / 100.0];
    }
    
    return self;
}

#pragma mark -
- (void)getStatusStrByModelStatus:(NSString *)modelStatus {
    NSString *str = @"";
    if ([modelStatus isEqualToString:@"10"]) {
        self.isFinished = NO;
        str = @"等待付款";
        if (self.isReservation) {
            self.isBtn1Hidden = YES;
            self.isBtn2Hidden = YES;
        } else {
            self.isBtn1Hidden = NO;
            self.btn1TitleStr = @"取消订单";
            self.btn1BgColor = [UIColor colorWithHexString:@"a9c1c8"];//灰色
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"付款";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];//紫色
        }
    } else if ([modelStatus isEqualToString:@"11"]) {
        self.isFinished = NO;
        str = @"等待咨询";
        if (self.isReservation) {
            self.isBtn1Hidden = NO;
            self.btn1TitleStr = @"电话沟通";
            self.btn1BgColor = [UIColor colorWithHexString:@"a773af"];
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"完成";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];
        } else {
            self.isBtn1Hidden = NO;
            self.btn1TitleStr = @"取消订单";
            self.btn1BgColor = [UIColor colorWithHexString:@"a9c1c8"];
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"电话沟通";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];
        }
    } else if ([modelStatus isEqualToString:@"12"]) {
        self.isFinished = NO;
        str = @"咨询中";
        if (self.isReservation) {
            self.isBtn1Hidden = NO;
            self.btn1TitleStr = @"电话沟通";
            self.btn1BgColor = [UIColor colorWithHexString:@"a773af"];
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"完成";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];
        } else {
            self.isBtn1Hidden = YES;
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"电话沟通";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];
        }
    } else if ([modelStatus isEqualToString:@"13"]) {
        self.isFinished = NO;
        str = @"等待评价";
        if (self.isReservation) {
            self.isBtn1Hidden = YES;
            self.isBtn2Hidden = YES;
        } else {
            self.isBtn1Hidden = YES;
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"评价";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];
        }
    } else if ([modelStatus isEqualToString:@"14"]) {
        self.isFinished = YES;
        str = @"已评价";
        if (self.isReservation) {
            self.isBtn1Hidden = YES;
            self.isBtn2Hidden = YES;
        } else {
            self.isBtn1Hidden = YES;
            self.isBtn2Hidden = NO;
            self.btn2TitleStr = @"再次预约";
            self.btn2BgColor = [UIColor colorWithHexString:@"a773af"];
        }
    }
    
    self.statusStr = str;
}

@end
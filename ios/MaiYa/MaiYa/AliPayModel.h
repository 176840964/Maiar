//
//  AliPayModel.h
//  MaiYa
//
//  Created by zxl on 15/11/20.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface AliPayModel : BaseModel
@property (copy, nonatomic) NSString *tradeNO;
@property (copy, nonatomic) NSString *productName;
@property (copy, nonatomic) NSString *productDescription;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *notifyURL;
@property (copy, nonatomic) NSString *itBPAY;

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * showUrl;

@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;
@end

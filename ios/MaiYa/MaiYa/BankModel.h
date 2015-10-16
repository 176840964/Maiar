//
//  BankModel.h
//  MaiYa
//
//  Created by zxl on 15/10/15.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface BankModel : BaseModel

@property (copy, nonatomic) NSString *bid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *url;

@end

@interface BankViewModel : NSObject
@property (copy, nonatomic) NSString *bankIdStr;
@property (copy, nonatomic) NSString *bankNameStr;
@property (copy, nonatomic) NSString *bankOrderStr;
@property (strong, nonatomic) NSURL *url;


- (instancetype)initWithBankModel:(BankModel*)model;
@end

//
//  MasterListParaModel.h
//  MaiYa
//
//  Created by zxl on 15/11/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OrderTypeOfCommentNum @"commentnum"
#define OrderTypeOfHourMoney @"hour_money"

@interface MasterListParaModel : NSObject

@property (copy, nonatomic) NSString *distance;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *money_s;
@property (copy, nonatomic) NSString *money_e;
@property (copy, nonatomic) NSString *time;

@property (strong, nonatomic) NSMutableDictionary *dic;

@property (assign, nonatomic) BOOL isNeedReloadData;

- (instancetype)initWithCatStr:(NSString *)catStr;

@end

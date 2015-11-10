//
//  OrderDateModel.h
//  MaiYa
//
//  Created by zxl on 15/11/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDateModel : NSObject

@property (copy, nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSArray *timesArr;

- (instancetype)initWithDateString:(NSString *)dateStr;

@end

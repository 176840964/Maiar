//
//  ArticleCatModel.h
//  MaiYa
//
//  Created by zxl on 15/9/25.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleCatModel : BaseModel
@property (copy, nonatomic) NSString *aid;
@property (copy, nonatomic) NSString *detail;
@property (strong, nonatomic) NSNumber *type;
@end

@interface ArticleCatViewModel : NSObject
@property (copy, nonatomic) NSString *aidStr;
@property (copy, nonatomic) NSString *detailStr;
@property (strong, nonatomic) NSNumber *typeNum;

- (instancetype)initWithArticleCatModel:(ArticleCatModel *)model;
@end
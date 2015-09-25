//
//  ArticleCatModel.m
//  MaiYa
//
//  Created by zxl on 15/9/25.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ArticleCatModel.h"

@implementation ArticleCatModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.aid = [dic objectForKey:@"id"];
    }
    
    return self;
}

@end

@implementation ArticleCatViewModel

- (instancetype)initWithArticleCatModel:(ArticleCatModel *)model {
    if (self = [super init]) {
        self.aidStr = model.aid;
        self.detailStr = model.detail;
        self.typeNum = model.type;
    }
    
    return self;
}

@end
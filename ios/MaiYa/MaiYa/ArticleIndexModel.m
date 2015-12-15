//
//  ArticleIndexModel.m
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ArticleIndexModel.h"

@implementation ArticleIndexModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.aid = [dic objectForKey:@"id"];
    }
    
    return self;
}

@end

@implementation ArticleIndexViewModel
- (instancetype)initWithAritcleIndexModel:(ArticleIndexModel *)model {
    if (self = [super init]) {
        self.aidStr = model.aid;
        self.titleStr = model.ztitle;
        self.shareUrlStr = model.share_url;
    }
    
    return self;
}

@end

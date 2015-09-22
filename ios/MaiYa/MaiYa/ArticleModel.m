//
//  FocusModel.m
//  MaiYa
//
//  Created by zxl on 15/9/22.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.aid = [dic objectForKey:@"id"];
    }
    return self;
}

@end

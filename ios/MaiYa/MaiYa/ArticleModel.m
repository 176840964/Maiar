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

@implementation ArticleViewModel

- (instancetype)initWithArticleModel:(ArticleModel *)model {
    if (self = [super init]) {
        self.aidStr = model.aid;
        self.titleStr = model.title;
        self.abstractStr = model.abstract;
        self.imgUrl = [NSURL URLWithString:model.img];
        self.url = [NSURL URLWithString:model.url];
        self.readStr = model.read;
        self.praiseStr = model.praise;
        self.ctimeStr = model.ctime;
        self.nickStr = model.nick;
        self.headUrl = [NSURL URLWithString:model.url];
        self.uidStr = model.uid;
        self.typeStr = model.type;
    }
    
    return self;
}

@end

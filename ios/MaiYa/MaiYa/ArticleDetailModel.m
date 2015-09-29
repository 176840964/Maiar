//
//  ArticleDetailModel.m
//  MaiYa
//
//  Created by zxl on 15/9/29.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ArticleDetailModel.h"

@implementation ArticleDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.aid = [dic objectForKey:@"id"];
    }
    
    return self;
}

@end

@implementation ArticleDetailViewModel

- (instancetype)initWithArticleDetailModel:(ArticleDetailModel *)model {
    if (self = [super init]) {
        self.aidStr = model.aid;
        self.titleStr = model.title;
        self.contentStr = model.content;
        self.readStr = model.read;
        self.praiseStr = model.praise;
        self.ctimeStr = model.ctime;
        self.uidStr = model.uid;
        self.nickStr = model.nick;
        self.headStr = model.head;
        self.genderStr = model.gender;
        self.introduceStr = model.introduce;
        self.typeStr = model.type;
        self.utypeStr = model.utype;
    }
    
    return self;
}

@end

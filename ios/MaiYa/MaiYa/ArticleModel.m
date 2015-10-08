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
    self = [super initWithDic:dic];
    if (self) {
        self.aid = [dic objectForKey:@"id"];
    }
    return self;
}

@end

@implementation ArticleViewModel

- (instancetype)initWithArticleModel:(ArticleModel *)model {
    if (self = [super init]) {
        self.aidStr = [model.aid stringValue];
        self.titleStr = [model.title stringValue];
        self.digestStr = [model.digest stringValue];
        self.imgUrl = [NSURL URLWithString:[model.img stringValue]];
        self.url = [NSURL URLWithString:[model.url stringValue]];
        self.readStr = [NSString stringWithFormat:@"阅读%@", [model.read stringValue]];
        self.praiseStr = [model.praise stringValue];
        self.nickStr = [model.nick stringValue];
        self.headUrl = [NSURL URLWithString:[model.url stringValue]];
        self.uidStr = [model.uid stringValue];
        self.typeStr = [model.type stringValue];
        
        self.ctimeStr = [CustomTools dateStringFromUnixTimestamp:[model.ctime stringValue].integerValue withFormatString:@"EEa HH:mm"];
    }
    
    return self;
}

@end

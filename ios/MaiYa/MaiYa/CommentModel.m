//
//  CommentModel.m
//  MaiYa
//
//  Created by zxl on 15/9/29.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super initWithDic:dic]) {
        self.cid = [dic objectForKey:@"id"];
    }
    
    return self;
}
@end

@implementation CommentViewModel

- (instancetype)initWithCommentModel:(CommentModel *)model {
    if (self = [super init]) {
        self.cidStr = model.cid;
        self.uidStr = model.uid;
        self.contentStr = model.content;
        self.starNum = [NSNumber numberWithInteger:model.star.integerValue];
        self.usernameStr = model.username;
        
        self.ctimeStr = [CustomTools dateStringFromUnixTimestamp:[model.ctime stringValue].integerValue withFormatString:@"yyyy年MM月dd日"];
    }
    
    return self;
}

@end

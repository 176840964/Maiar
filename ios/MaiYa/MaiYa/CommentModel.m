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
        self.cidStr = [model.cid stringValue];
        self.uidStr = [model.uid stringValue];
        self.contentStr = [model.content stringValue];
        self.starCountStr = [model.star stringValue];
        self.usernameStr = [NSString stringWithFormat:@"用户：%@", [model.username stringValue]];
        
        self.ctimeStr = [CustomTools dateStringFromUnixTimestamp:[model.ctime stringValue].integerValue withFormatString:@"yyyy年MM月dd日"];
    }
    
    return self;
}

@end

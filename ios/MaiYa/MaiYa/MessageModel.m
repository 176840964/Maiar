//
//  MessageModel.m
//  MaiYa
//
//  Created by zxl on 15/10/20.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

@end

@implementation MessageViewModel

- (instancetype)initWithMessageModel:(MessageModel *)model {
    if (self = [super init]) {
        self.titleStr = [model.title stringValue];;
        self.contentStr = [model.content stringValue];
        self.timeStr = [CustomTools dateStringFromUnixTimestamp:model.ctime.integerValue withFormatString:@"yyyy-MM-dd hh:mm:ss"];
        self.textColor = [model.status isEqualToString:@"0"] ? [UIColor colorWithHexString:@"#667785"] : [UIColor colorWithHexString:@"#cddade"];
    }
    
    return self;
}

@end

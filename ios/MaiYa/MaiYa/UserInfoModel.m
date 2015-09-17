//
//  UserInfoModel.m
//  MaiYa
//
//  Created by zxl on 15/9/17.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

@end


@implementation UserInfoViewModel

- (instancetype)initWithModel:(UserInfoModel *)model {
    if (self = [super init]) {
        self.uidStr = [model.uid stringValue];
        self.nickStr = [model.nick stringValue];
        
        self.headImage = [UIImage imageNamed:[model.head isEqual:[NSNull null]]? @"defulteHead" : model.head];
        self.tokenStr = [model.token stringValue];
        
        NSString *sexStr = [model.gender stringValue];
        if ([sexStr isEqualToString:@"1"]) {
            self.sexImage = [UIImage imageNamed:@"man1"];
        } else {
            self.sexImage = [UIImage imageNamed:@"woman1"];
        }
    }
    
    return self;
}

@end
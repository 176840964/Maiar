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
        
        self.headUrl = [NSURL URLWithString:[model.head stringValue]];
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

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uidStr forKey:@"uid"];
    [aCoder encodeObject:self.tokenStr forKey:@"token"];
    [aCoder encodeObject:self.nickStr forKey:@"nick"];
    [aCoder encodeObject:self.headUrl forKey:@"head_url"];
    [aCoder encodeObject:self.sexImage forKey:@"sex_image"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.uidStr = [aDecoder decodeObjectForKey:@"uid"];
        self.tokenStr = [aDecoder decodeObjectForKey:@"token"];
        self.nickStr = [aDecoder decodeObjectForKey:@"nick"];
        self.headUrl = [aDecoder decodeObjectForKey:@"head_url"];
        self.sexImage = [aDecoder decodeObjectForKey:@"sex_image"];
    }
    
    return self;
}

@end
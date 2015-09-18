//
//  NSObject+ValueOfStringOrNull.m
//  MaiYa
//
//  Created by zxl on 15/9/18.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NSObject+ValueOfStringOrNull.h"

@implementation NSObject (ValueOfStringOrNull)

- (NSString *)stringValue {
    if ([self isEqual:[NSNull null]]) {
        return @"";
    } else {
        return (NSString *)self;
    }
}

- (NSString *)stringValueIsNullReplaceString:(NSString *)replaceStr {
    if ([self isEqual:[NSNull null]]) {
        return replaceStr;
    } else if ([self isEqual:[NSString class]]) {
        return (NSString *)self;
    } else {
        return @"";
    }
}
@end

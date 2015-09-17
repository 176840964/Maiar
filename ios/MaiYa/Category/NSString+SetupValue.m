//
//  NSString+SetupValue.m
//  MaiYa
//
//  Created by zxl on 15/9/17.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NSString+SetupValue.h"

@implementation NSString (SetupValue)

- (NSString *)stringValue {
    return [self isEqual:[NSNull null]] ? @"" : self;
}

- (NSString*)stringValueIsNullReplaceString:(NSString *)replaceStr {
    return [self isEqual:[NSNull null]] ? @"replaceStr" : self;
}

@end

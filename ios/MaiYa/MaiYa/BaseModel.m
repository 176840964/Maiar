//
//  BaseModel.m
//  MaiYa
//
//  Created by zxl on 15/9/17.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        for (NSString* key in dic.allKeys) {
            object_setInstanceVariable(self, [NSString stringWithFormat:@"_%@", key].UTF8String, [dic objectForKey:key]);
        }
    }
    return self;
}

@end

//
//  NSObject+ValueOfStringOrNull.h
//  MaiYa
//
//  Created by zxl on 15/9/18.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ValueOfStringOrNull)

- (NSString *)stringValue;
- (NSString*)stringValueIsNullReplaceString:(NSString *)replaceStr;

@end

//
//  NSString+Valid.m
//  MaiYa
//
//  Created by zxl on 15/11/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

- (BOOL)isValid {
    return [self isKindOfClass:[NSString class]] && 0 != self.length;
}

@end

//
//  UITextField+PlaceholderTextColor.m
//  MaiYa
//
//  Created by zxl on 15/8/20.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UITextField+PlaceholderTextColor.h"

@implementation UITextField (PlaceholderTextColor)

- (UIColor *)placeholderTextColor {
    return (UIColor *)[self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    [self setValue:placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end

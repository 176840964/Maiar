//
//  UITextField+PlaceholderText.m
//  MaiYa
//
//  Created by zxl on 15/8/20.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UITextField+PlaceholderText.h"

@implementation UITextField (PlaceholderText)

- (UIColor *)placeholderTextColor {
    return (UIColor *)[self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    [self setValue:placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIFont *)placeholderFont {
    return (UIFont *)[self valueForKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

@end

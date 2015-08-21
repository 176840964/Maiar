//
//  UIView+frameAdjust.h
//  MaiYa
//
//  Created by zxl on 15/8/12.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAdjust)

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)cornerRadius;

- (CGFloat)borderWidth;
- (void)setBorderWidth:(CGFloat)borderWidth;

- (UIColor *)borderColor;
- (void)setBorderColor:(UIColor *)borderColor;

@end

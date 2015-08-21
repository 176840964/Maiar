//
//  UIView+frameAdjust.m
//  MaiYa
//
//  Created by zxl on 15/8/12.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UIView+frameAdjust.h"

@implementation UIView (frameAdjust)
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

@end

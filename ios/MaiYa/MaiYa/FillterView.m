//
//  FillterView.m
//  MaiYa
//
//  Created by zxl on 15/9/6.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "FillterView.h"
#import "FillterDateView.h"

@interface FillterView ()

@property (weak, nonatomic) IBOutlet UIImageView *minImg;
@property (weak, nonatomic) IBOutlet UIImageView *maxImg;
@property (weak, nonatomic) IBOutlet UIView *priceSpaceBg;

@property (strong, nonatomic) IBOutletCollection(FillterDateView) NSArray *dateViewArr;

@property (assign, nonatomic) CGPoint beginPoint;
@property (copy, nonatomic) NSString* minPrice;
@property (copy, nonatomic) NSString* maxPrice;

@end

@implementation FillterView

- (void)setupFillterSubViews {
    self.dateViewArr = [self.dateViewArr sortByUIViewOriginX];
    
    NSDate *todayZeroClock = [NSDate todayZeroClock];
    
    for (NSInteger index = 0; index < self.dateViewArr.count; index ++) {
        FillterDateView *dateView = [self.dateViewArr objectAtIndex:index];
        [dateView layoutSubviewsWithTimestamp:todayZeroClock.timeIntervalSince1970 + 3600 * 24 * index];
    }
}

- (NSString *)timeFillterStr {
    _timeFillterStr = nil;
    for (FillterDateView * dateView in self.dateViewArr) {
        if ([dateView.paraValueString isValid]) {
            if (![_timeFillterStr isValid]) {
                _timeFillterStr = dateView.paraValueString;
            } else {
                _timeFillterStr = [NSString stringWithFormat:@"%@,%@", _timeFillterStr, dateView.paraValueString];
            }
        }
    }
    
    return _timeFillterStr;
}

#pragma mark -
- (NSString*)getPriceStrWithCenterPoint:(CGPoint)center {
    NSString* str = @"";
    CGFloat offset = CGRectGetWidth(self.priceSpaceBg.frame) / 5.0;
    NSInteger index = (center.x - 13) / offset;
    switch (index) {
        case 0:
            str = @"0";
            break;
        case 1:
            str = @"100";
            break;
        case 2:
            str = @"150";
            break;
        case 3:
            str = @"200";
            break;
        case 4:
            str = @"300";
            break;
        default:
            str = @"all";
            break;
    }
    
    return str;
}

#pragma mark - IBAction
- (IBAction)panMinImg:(id)sender {
    UIPanGestureRecognizer *pan = sender;
    
    if (UIGestureRecognizerStateBegan == pan.state) {
        _beginPoint = [pan translationInView:self];
    } else if (UIGestureRecognizerStateChanged == pan.state) {
        CGPoint point = [pan translationInView:self];
        CGPoint changedPoint = CGPointMake(point.x - _beginPoint.x, point.y - _beginPoint.y);
        _beginPoint = point;
        
        CGFloat minCenterX = _minImg.center.x + changedPoint.x;
        CGFloat maxCenterX = _maxImg.center.x;
        
        if (minCenterX <= CGRectGetMinX(self.priceSpaceBg.frame)) {
            minCenterX = CGRectGetMinX(self.priceSpaceBg.frame);
        } else if (minCenterX >= (maxCenterX - CGRectGetMaxX(self.priceSpaceBg.frame) / 5)) {
            minCenterX = (maxCenterX - CGRectGetMaxX(self.priceSpaceBg.frame) / 5);
        }
        _minImg.center = CGPointMake(minCenterX, _minImg.center.y);
    } else if (UIGestureRecognizerStateEnded == pan.state) {
        CGFloat offset = CGRectGetWidth(self.priceSpaceBg.frame) / 5.0;
        CGFloat currentPos = _minImg.center.x - CGRectGetMinX(self.priceSpaceBg.frame);
        NSInteger num_integer = currentPos / offset;
        CGFloat up_offset = offset * (num_integer + 1) - currentPos;
        CGFloat down_offset = offset * num_integer - currentPos;
        if (fabs(up_offset) >= fabs(down_offset)) {
            _minImg.center = CGPointMake(offset * num_integer + CGRectGetMinX(self.priceSpaceBg.frame), _minImg.center.y);
        } else {
            _minImg.center = CGPointMake(offset * (num_integer + 1) + CGRectGetMinX(self.priceSpaceBg.frame), _minImg.center.y);
        }
        
        _minPrice = [self getPriceStrWithCenterPoint:_minImg.center];
    }
}

- (IBAction)panMaxImg:(id)sender {
    UIPanGestureRecognizer *pan = sender;
    
    if (UIGestureRecognizerStateBegan == pan.state) {
        _beginPoint = [pan translationInView:self];
    } else if (UIGestureRecognizerStateChanged == pan.state) {
        CGPoint point = [pan translationInView:self];
        CGPoint changedPoint = CGPointMake(point.x - _beginPoint.x, point.y - _beginPoint.y);
        _beginPoint = point;
        
        CGFloat minCenterX = _minImg.center.x;
        CGFloat maxCenterX = _maxImg.center.x + changedPoint.x;
        
        if (maxCenterX >= CGRectGetMaxX(self.priceSpaceBg.frame)) {
            maxCenterX = CGRectGetMaxX(self.priceSpaceBg.frame);
        } else if (maxCenterX <= (minCenterX + CGRectGetMaxX(self.priceSpaceBg.frame) / 5)) {
            maxCenterX = (minCenterX + CGRectGetMaxX(self.priceSpaceBg.frame) / 5);
        }
        _maxImg.center = CGPointMake(maxCenterX, _minImg.center.y);
    } else if (UIGestureRecognizerStateEnded == pan.state) {
        CGFloat offset = CGRectGetWidth(self.priceSpaceBg.frame) / 5.0;
        CGFloat currentPos = _maxImg.center.x - CGRectGetMinX(self.priceSpaceBg.frame);
        NSInteger num_integer = currentPos / offset;
        CGFloat up_offset = offset * (num_integer + 1) - currentPos;
        CGFloat down_offset = offset * num_integer - currentPos;
        if (fabs(up_offset) >= fabs(down_offset)) {
            _maxImg.center = CGPointMake(offset * num_integer + CGRectGetMinX(self.priceSpaceBg.frame), _maxImg.center.y);
        } else {
            _maxImg.center = CGPointMake(offset * (num_integer + 1) + CGRectGetMinX(self.priceSpaceBg.frame), _maxImg.center.y);
        }
        
        _maxPrice = [self getPriceStrWithCenterPoint:_maxImg.center];
    }
}

@end

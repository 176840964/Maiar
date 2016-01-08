//
//  HintView.m
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "HintView.h"

typedef void(^DismissBlock)();

@interface HintView ()
@property (nonatomic, strong) UIControl *closeCtrl;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) NSTimer *presentTimer;
@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, strong) UIView *activityBg;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@end

@implementation HintView
+ (instancetype)getInstance {
    static HintView *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[HintView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    return s_instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _closeCtrl = [[UIControl alloc] initWithFrame:frame];
        _closeCtrl.enabled = NO;
        _closeCtrl.backgroundColor = [UIColor clearColor];
        [_closeCtrl addTarget:self action:@selector(dismissMessage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeCtrl];
        
        _messageLab = [UILabel newAutoLayoutView];
        _messageLab.numberOfLines = 2;
        _messageLab.hidden = YES;
        _messageLab.clipsToBounds = YES;
        _messageLab.cornerRadius = 5;
        _messageLab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
        _messageLab.textColor = [UIColor whiteColor];
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.font = [UIFont systemFontOfSize:20];
        [self addSubview:_messageLab];
        
        [_messageLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:CGRectGetHeight(frame) / 5 * 3];
        [_messageLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
        [_messageLab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
        [_messageLab autoSetDimension:ALDimensionHeight toSize:60];
        
        _activityBg = [UIView newAutoLayoutView];
        _activityBg.hidden = YES;
        _activityBg.backgroundColor = [UIColor grayColor];
        _activityBg.cornerRadius = 5;
        [self addSubview:_activityBg];
        
        [_activityBg autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_activityBg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_activityBg autoSetDimension:ALDimensionWidth toSize:50];
        [_activityBg autoSetDimension:ALDimensionHeight toSize:50];
        
        _activityView = [UIActivityIndicatorView newAutoLayoutView];
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _activityView.hidden = YES;
        [_activityBg addSubview:_activityView];
        
        [_activityView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_activityView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    }
    
    return self;
}

- (void)presentMessage:(NSString *)message isAutoDismiss:(BOOL)isAuto dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^)(void))dismissBlock {
    
    self.messageLab.text = message;
    self.hidden = NO;
    self.messageLab.hidden = NO;
    self.messageLab.alpha = 0.0;
    [UIView animateWithDuration:seconds / 2 animations:^{
        self.messageLab.alpha = 1.0;
        self.messageLab.transform = CGAffineTransformMakeTranslation(0, -10);
    } completion:^(BOOL finished) {
        
    }];
    
    if (dismissBlock) {
        self.dismissBlock = dismissBlock;
    }
    
    if (isAuto) {
        self.closeCtrl.enabled = NO;
        self.presentTimer = [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(dismissMessage) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.presentTimer forMode:NSRunLoopCommonModes];
    } else {
        self.closeCtrl.enabled = YES;
    }
}

- (void)startLoadingMessage:(NSString *)startMessage {
    self.closeCtrl.enabled = NO;
    self.messageLab.text = startMessage;
    self.hidden = NO;
    self.messageLab.hidden = NO;
    self.messageLab.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        self.messageLab.alpha = 1.0;
        self.messageLab.transform = CGAffineTransformMakeTranslation(0, -10);
    }];
}

- (void)endLoadingMessage:(NSString *)endMessage dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^) (void))dismissBlock {
    if (endMessage.isValid) {
        self.messageLab.text = endMessage;
    }
    
    if (dismissBlock) {
        self.dismissBlock = dismissBlock;
    }
    
    self.presentTimer = [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(dismissMessage) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.presentTimer forMode:NSRunLoopCommonModes];
}

- (void)dismissMessage {
    [UIView animateWithDuration:1 animations:^{
        self.messageLab.alpha = 0.0;
        self.messageLab.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self endSimpleLoading];
        self.hidden = YES;
        self.messageLab.hidden = YES;
        self.messageLab.text = @"";
        [self.presentTimer invalidate];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }];
}

- (void)showSimpleLoading {
    self.hidden = NO;
    self.activityBg.hidden = NO;
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}

- (void)endSimpleLoading {
    self.hidden = YES;
    self.activityBg.hidden = YES;
    self.activityView.hidden = YES;
}

@end

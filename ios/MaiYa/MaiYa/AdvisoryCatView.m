//
//  AdvisoryCatView.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryCatView.h"

@interface AdvisoryCatView ()
@property (strong, nonatomic) UIImageView *bgMarkImageView;
@property (strong, nonatomic) UIControl *contentView;
@end

@implementation AdvisoryCatView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.bgMarkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"advisory_mark"]];
        self.bgMarkImageView.frame = self.bounds;
        self.bgMarkImageView.alpha = 0;
        [self addSubview:self.bgMarkImageView];
        
        self.contentView = [UIControl newAutoLayoutView];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addTarget:self action:@selector(onTapBgMarkCtrl:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.contentView];
        
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"请任选一种咨询方式";
        lab.font = [UIFont systemFontOfSize:17];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
        
        [lab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
        [lab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [lab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [lab autoSetDimension:ALDimensionHeight toSize:20];
        
        UIButton *btn0 = [UIButton newAutoLayoutView];
        btn0.tag = 40;
        [btn0 setImage:[UIImage imageNamed:@"advisory_zhanxing"] forState:UIControlStateNormal];
        [btn0 addTarget:self action:@selector(onTapCatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn0];
        
        [btn0 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [btn0 autoSetDimension:ALDimensionWidth toSize:235];
        [btn0 autoSetDimension:ALDimensionHeight toSize:94];
        [btn0 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lab withOffset:25];
        
        UIButton *btn1 = [UIButton newAutoLayoutView];
        btn1.tag = 41;
        [btn1 setImage:[UIImage imageNamed:@"advisory_taluo"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(onTapCatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn1];
        
        [btn1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [btn1 autoSetDimension:ALDimensionWidth toSize:235];
        [btn1 autoSetDimension:ALDimensionHeight toSize:94];
        [btn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:btn0 withOffset:21];
        
        UIButton *btn2 = [UIButton newAutoLayoutView];
        btn2.tag = 42;
        [btn2 setImage:[UIImage imageNamed:@"advisory_zhouyi"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(onTapCatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn2];
        
        [btn2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [btn2 autoSetDimension:ALDimensionWidth toSize:235];
        [btn2 autoSetDimension:ALDimensionHeight toSize:94];
        [btn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:btn1 withOffset:21];
        
        self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        self.catModel = AdvisoryCatModelNone;
    }
    
    return self;
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgMarkImageView.alpha = 1.0;
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark -
- (void)onTapBgMarkCtrl:(UIControl *)ctrl {
    self.catModel = 3;
    [self closeOfIsSelectedCat:NO];
}

- (void)onTapCatBtn:(UIButton *)btn {
    self.catModel = btn.tag;
    
    [self closeOfIsSelectedCat:YES];
}

- (void)closeOfIsSelectedCat:(BOOL)isSelected {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        self.bgMarkImageView.alpha = 0;
        self.hidden = YES;
        
        if (isSelected && self.selectedAdvisoryCatHandler) {
            self.selectedAdvisoryCatHandler([NSNumber numberWithInteger:self.catModel]);
        }
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

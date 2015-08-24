//
//  MeHeaderView.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MeHeaderView.h"

@interface MeHeaderView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView* userHeadPortrait;
@property (nonatomic, strong) UIImageView* editInfoIcon;
@property (nonatomic, strong) UILabel* userNameLab;
@property (nonatomic, strong) UIImageView* userSexIcon;
@end

@implementation MeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithR:240 g:241 b:245];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 206)];
        self.contentView.backgroundColor = [UIColor colorWithR:100 g:81 b:152];
        [self addSubview:self.contentView];
        
        self.userHeadPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x - 108 / 2.0, 95 / 2.0, 108, 108)];
        self.userHeadPortrait.image = [UIImage imageNamed:@"login_bg"];
        self.userHeadPortrait.userInteractionEnabled = YES;
        self.userHeadPortrait.clipsToBounds = YES;
        self.userHeadPortrait.cornerRadius = self.userHeadPortrait.width / 2.0;
        self.userHeadPortrait.borderWidth = 2;
        self.userHeadPortrait.borderColor = [UIColor whiteColor];
        [self addSubview:self.userHeadPortrait];
        
        UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapUserHeadPortrait:)];
        [self.userHeadPortrait addGestureRecognizer:pan];
        
        self.editInfoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userHeadPortrait.frame) - 21, CGRectGetMinY(self.userHeadPortrait.frame) + 10, 21, 21)];
        self.editInfoIcon.image = [UIImage imageNamed:@"editIcon"];
        self.editInfoIcon.userInteractionEnabled = YES;
        [self addSubview:self.editInfoIcon];
        
        self.userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userHeadPortrait.frame), CGRectGetMaxY(self.userHeadPortrait.frame) + 8, 108, 20)];
        self.userNameLab.text = @"废腿小能手";
        self.userNameLab.textColor = [UIColor whiteColor];
        self.userNameLab.textAlignment = NSTextAlignmentCenter;
        self.userNameLab.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.userNameLab];
        
        self.userSexIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"man1"]];
        self.userSexIcon.frame = CGRectMake(CGRectGetMaxX(self.userNameLab.frame), CGRectGetMinY(self.userNameLab.frame), 16, 16);
        [self addSubview:self.userSexIcon];
    }
    
    return self;
}

#pragma mark - 
- (void)onTapUserHeadPortrait:(UIGestureRecognizer *)gestureRegognizer {
    if (self.tapUserHeadPortraitHandler) {
        self.tapUserHeadPortraitHandler();
    }
}

@end

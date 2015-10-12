//
//  CommentHeaderView.m
//  MaiYa
//
//  Created by zxl on 15/9/10.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView ()
@property (strong, nonatomic) UILabel *countLab;
@property (strong, nonatomic) UILabel *scroeLab;
@property (strong, nonatomic) NSArray *starArr;
@end

@implementation CommentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.countLab = [UILabel newAutoLayoutView];
        [self addSubview:self.countLab];
        
        self.scroeLab = [UILabel newAutoLayoutView];
        self.scroeLab.textColor = [UIColor colorWithHexString:@"#ff9c00"];
        self.scroeLab.textAlignment = NSTextAlignmentRight;
        self.scroeLab.font = [UIFont systemFontOfSize:12.5];
        [self addSubview:self.scroeLab];
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSInteger index = 0; index < 5; ++index) {
            UIImageView *star = [UIImageView newAutoLayoutView];
            star.image = [UIImage imageNamed:@"smallStar0"];
            [self addSubview:star];
            [arr addObject:star];
        }
        self.starArr = [NSArray arrayWithArray:arr];
        
        [self setupSubviewsConstrains];
    }
    
    return self;
}

- (void)layoutCommentHeaderViewSubviewsCountString:(NSString *)countStr andAllValueString:(NSString *)allValueStr {
    self.scroeLab.text = allValueStr;
    
    for (NSInteger index = 0; index < allValueStr.integerValue; ++index) {
        UIImageView* star = [self.starArr objectAtIndex:index];
        star.image = [UIImage imageNamed:@"smallStar1"];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总评价%@", countStr]];
    [str addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.5], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(0, 3)];
    [str addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#8898a5"]} range:NSMakeRange(3, str.length - 3)];
    self.countLab.attributedText = str;
}

#pragma mark - 
- (void)setupSubviewsConstrains {
    
    for (NSInteger index = 0; index < 5; ++index) {
        UIImageView* star = [self.starArr objectAtIndex:index];
        
        [star autoSetDimension:ALDimensionWidth toSize:14];
        [star autoSetDimension:ALDimensionHeight toSize:13];
        [star autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        if (4 == index) {
            [star autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
        } else {
            UIImageView *nextStar = [self.starArr objectAtIndex:index + 1];
            [star autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:nextStar withOffset:-4];
        }
    }
    
    UIImageView* star = [self.starArr objectAtIndex:0];
    
    [self.scroeLab autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:star withOffset:-4];
    [self.scroeLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.scroeLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.scroeLab autoSetDimension:ALDimensionWidth toSize:30];
    
    [self.countLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [self.countLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.countLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.countLab autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.scroeLab withOffset:-8];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

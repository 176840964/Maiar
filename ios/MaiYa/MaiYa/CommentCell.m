//
//  CommentCell.m
//  MaiYa
//
//  Created by zxl on 15/9/10.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *dateLab;
@property (strong, nonatomic) UILabel *userLab;
@property (strong, nonatomic) NSArray *starArr;
@property (strong, nonatomic) UILabel *contentLab;

@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgView = [UIView newAutoLayoutView];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        self.dateLab = [UILabel newAutoLayoutView];
        self.dateLab.font = [UIFont systemFontOfSize:10];
        self.dateLab.textColor = [UIColor colorWithHexString:@"#8898a5"];
        [self.bgView addSubview:self.dateLab];
        
        self.userLab = [UILabel newAutoLayoutView];
        self.userLab.font = [UIFont systemFontOfSize:10];
        self.userLab.textAlignment = NSTextAlignmentCenter;
        self.userLab.textColor = [UIColor colorWithHexString:@"#8898a5"];
        [self.bgView addSubview:self.userLab];
        
        NSMutableArray *starArr = [NSMutableArray new];
        for (NSInteger index = 0; index < 5; index++) {
            UIImageView *star = [UIImageView newAutoLayoutView];
            star.image = [UIImage imageNamed:@"smallStar0"];
            [self.bgView addSubview:star];
            [starArr addObject:star];
        }
        self.starArr = [NSArray arrayWithArray:starArr];
        
        self.contentLab = [UILabel newAutoLayoutView];
        self.contentLab.font = [UIFont systemFontOfSize:13];
        self.contentLab.numberOfLines = 0;
        self.contentLab.textColor = [UIColor colorWithHexString:@"#8898a5"];
        [self.bgView addSubview:self.contentLab];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        
        [self.dateLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:8];
        [self.dateLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
        [self.dateLab autoSetDimension:ALDimensionWidth toSize:80];
        [self.dateLab autoSetDimension:ALDimensionHeight toSize:12];
        
        [self.userLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
        [self.userLab autoSetDimension:ALDimensionHeight toSize:12];
        [self.userLab autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.dateLab withOffset:8];
        
        for (NSInteger index = 0; index < self.starArr.count; index ++) {
            UIImageView *starImage = [self.starArr objectAtIndex:index];
            [starImage autoSetDimension:ALDimensionWidth toSize:14];
            [starImage autoSetDimension:ALDimensionHeight toSize:13];
            [starImage autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:8 + (14 + 4) * (5 - index)];
            [starImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
        }
        
        [self.contentLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateLab withOffset:4];
        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:8];
        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:8];
        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:4];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.contentLab.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLab.frame);
}

- (void)layoutCommentCellSubviewsByCommentViewModel:(CommentViewModel *)viewModel {
    self.dateLab.text = viewModel.ctimeStr;
    self.userLab.text = viewModel.usernameStr;
    self.contentLab.text = viewModel.contentStr;
    
    for (NSInteger index = 0; index < self.starArr.count; ++index) {
        UIImageView *imageView = [self.starArr objectAtIndex:index];
        if (viewModel.starCountStr.integerValue > index) {
            imageView.image = [UIImage imageNamed:@"smallStar1"];
        } else {
            imageView.image = [UIImage imageNamed:@"smallStar0"];
        }
    }
    
    [super updateConstraints];
}

@end

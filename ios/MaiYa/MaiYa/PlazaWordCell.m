//
//  PlazaCell.m
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PlazaWordCell.h"

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f

@interface PlazaWordCell ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation PlazaWordCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgImageView = [UIImageView newAutoLayoutView];
        self.bgImageView.image = [[UIImage imageNamed:@"plazaBg1"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
        [self.contentView addSubview:self.bgImageView];
        
        self.textLab = [UILabel newAutoLayoutView];
        [self.textLab setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.textLab setNumberOfLines:0];
        [self.textLab setTextAlignment:NSTextAlignmentLeft];
        [self.textLab setTextColor:[UIColor colorWithHexString:@"#667785"]];
        self.textLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.textLab];
        
        self.bottomLineView = [UIView new];
        self.bottomLineView.backgroundColor = [UIColor colorWithR:247 g:247 b:247];
        self.bottomLineView.hidden = YES;
        [self.contentView addSubview:self.bottomLineView];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.bgImageView autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        
        [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
        [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        
//        [self.textLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLab withOffset:kLabelVerticalInsets relation:NSLayoutRelationGreaterThanOrEqual];
        [self.textLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:12 relation:NSLayoutRelationGreaterThanOrEqual];
        
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.textLab autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.textLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:23];
        [self.textLab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:23];
        [self.textLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:14];
        
        [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [self.bottomLineView autoSetDimension:ALDimensionHeight toSize:1];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.textLab.preferredMaxLayoutWidth = CGRectGetWidth(self.textLab.frame);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

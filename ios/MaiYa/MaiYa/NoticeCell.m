//
//  NoticeCell.m
//  MaiYa
//
//  Created by zxl on 15/8/25.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NoticeCell.h"

@interface NoticeCell ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation NoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgView = [UIView newAutoLayoutView];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        self.titleLab = [UILabel newAutoLayoutView];
        self.titleLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLab];
        
        self.dateLab = [UILabel newAutoLayoutView];
        self.dateLab.backgroundColor = [UIColor clearColor];
        self.dateLab.font = [UIFont systemFontOfSize:12];
        self.dateLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.dateLab];
        
        self.contentLab = [UILabel newAutoLayoutView];
        self.contentLab.font = [UIFont systemFontOfSize:12];
        self.contentLab.numberOfLines = 0;
        [self.contentView addSubview:self.contentLab];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
//        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.bgView autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        
        [self.titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:18];
        [self.titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:18];
        [self.titleLab autoSetDimension:ALDimensionHeight toSize:15];
        [self.titleLab autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.dateLab];
        
        [self.dateLab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:18];
        [self.dateLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:18];
        [self.dateLab autoSetDimension:ALDimensionHeight toSize:17];
        [self.dateLab autoSetDimension:ALDimensionWidth toSize:130];
        
//        [self.contentLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLab withOffset:8 relation:NSLayoutRelationGreaterThanOrEqual];
//        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.contentLab autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
        [self.contentLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLab withOffset:4];
        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:18];
        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:18];
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

- (void)layoutNoticCellSubviewsByMessageViewModel:(MessageViewModel *)viewModel {
    self.titleLab.text = viewModel.titleStr;
    self.titleLab.textColor = viewModel.textColor;
    self.dateLab.text = viewModel.timeStr;
    self.dateLab.textColor = viewModel.textColor;
    self.contentLab.text = viewModel.contentStr;
    self.contentLab.textColor = viewModel.textColor;
    
    [super updateConstraints];
}

@end

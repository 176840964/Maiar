//
//  MasterCell.m
//  MaiYa
//
//  Created by zxl on 15/8/27.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MasterCell.h"

@interface MasterCell ()
@property (nonatomic, weak) IBOutlet UIImageView *headImageView;
@property (nonatomic, weak) IBOutlet UIImageView *sexImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLab;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *workTypeLabsArr;
@property (nonatomic, weak) IBOutlet UILabel *evaluationLab;
@property (nonatomic, weak) IBOutlet UILabel *evaluationCountLab;
@property (nonatomic, weak) IBOutlet UILabel *locationLab;
@property (nonatomic, weak) IBOutlet UILabel *priceLab;

@end

@implementation MasterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutMasterCellSubviewsByUserZoneViewModel:(UserZoneViewModel *)userViewModel {
    [self.headImageView setImageWithURL:userViewModel.headUrl placeholderImage:[UIImage imageNamed:@"aboutIcon"]];
    self.sexImageView.image = userViewModel.sexImage;
    self.nameLab.attributedText = userViewModel.nickAndWorkAgeAttributedStr;
    self.evaluationLab.text = userViewModel.commentAllStr;
    self.evaluationCountLab.text = userViewModel.commentNumStr;
    
    self.workTypeLabsArr = [self.workTypeLabsArr sortByUIViewOriginX];
    for (NSInteger index = 0; index < self.workTypeLabsArr.count; ++index) {
        UILabel *lab = [self.workTypeLabsArr objectAtIndex:index];
        if (index >= userViewModel.workTypesArr.count) {
            lab.hidden = YES;
        } else {
            NSDictionary *dic = [userViewModel.workTypesArr objectAtIndex:index];
            lab.hidden = NO;
            lab.text = [dic objectForKey:@"text"];
            lab.backgroundColor = [dic objectForKey:@"bgColor"];
            lab.font = [dic objectForKey:@"font"];
        }
    }
    
    self.locationLab.text = userViewModel.distanceStr;
    self.priceLab.text = userViewModel.moneyPerHourStr;
}

@end

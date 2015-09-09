//
//  AdvisoryDetailMasterCell.h
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailUserCell.h"

@interface AdvisoryDetailMasterCell : AdvisoryDetailUserCell

@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *catsArr;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end

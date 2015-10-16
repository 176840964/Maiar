//
//  BackCell.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"
#import "AreaModel.h"

@interface BankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

- (void)layoutBankCellSubviewsByBankViewModel:(BankViewModel *)viewModel;
- (void)layoutBankCellSubviewsByAreaViewModel:(AreaViewModel *)viewModel;

@end

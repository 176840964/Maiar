//
//  FillterDateView.h
//  MaiYa
//
//  Created by zxl on 15/11/11.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FillterDateCellCtrl.h"

@interface FillterDateView : UIView

@property (weak, nonatomic) IBOutlet UILabel *weekLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutletCollection(FillterDateCellCtrl) NSArray *ctrlArr;

@property (assign, nonatomic) NSInteger timestamp;

@property (copy, nonatomic) NSString *paraValueString;

- (void)layoutSubviewsWithTimestamp:(NSInteger)timestamp;
@end

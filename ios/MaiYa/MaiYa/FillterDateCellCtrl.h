//
//  FillterDateCellCtrl.h
//  MaiYa
//
//  Created by zxl on 15/11/11.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FillterDateCellCtrl : UIControl

@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (assign, nonatomic) BOOL isSelected;
@property (copy, nonatomic) NSString *identifierStr;

@end

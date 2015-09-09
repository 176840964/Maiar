//
//  AdvisoryDetailEndCell.h
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryDetailEndCell : UITableViewCell

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *straImagesArr;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@end

//
//  MasterCell.h
//  MaiYa
//
//  Created by zxl on 15/8/27.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserZoneModel.h"

@interface MasterCell : UITableViewCell

- (void)layoutMasterCellSubviewsByUserZoneViewModel:(UserZoneViewModel *)userViewModel;

@end

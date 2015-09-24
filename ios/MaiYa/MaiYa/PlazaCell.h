//
//  PlazaCell.h
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDirectoryModel.h"

typedef void(^TapBtnHandle)(NSNumber *, NSString *);
typedef void(^TapCategoryBtnHandle)(NSNumber *);

@interface PlazaCell : UITableViewCell

@property (copy, nonatomic) TapBtnHandle tapBtnHandler;
@property (copy, nonatomic) TapCategoryBtnHandle tapCategoryBtnHandle;

- (void)layoutPlazaCellSubviewsByAritcleDirectoryViewModel:(ArticleDirectoryViewModel *)viewModel;

@end

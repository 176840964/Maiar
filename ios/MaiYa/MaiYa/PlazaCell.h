//
//  PlazaCell.h
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDirectoryModel.h"
#import "ArticleIndexModel.h"

typedef void(^TapBtnHandle)(NSString *, ArticleIndexViewModel *);
typedef void(^TapCategoryBtnHandle)(NSString *);

@interface PlazaCell : UITableViewCell

@property (copy, nonatomic) TapBtnHandle tapBtnHandler;
@property (copy, nonatomic) TapCategoryBtnHandle tapCategoryBtnHandle;

- (void)layoutPlazaCellSubviewsByAritcleDirectoryViewModel:(ArticleDirectoryViewModel *)viewModel;

@end

//
//  MySharingCell.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface MySharingCell : UITableViewCell

- (void)layoutMySharingCellSubviewsByArticleViewModel:(ArticleViewModel *)articleViewModel;

@end

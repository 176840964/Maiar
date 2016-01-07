//
//  MySharingCell.h
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

typedef void(^DeleteAriticleHandle)(NSString *aidStr);

@interface MySharingCell : UITableViewCell

@property (copy, nonatomic) DeleteAriticleHandle delAriticleHandle;

- (void)layoutMySharingCellSubviewsByArticleViewModel:(ArticleViewModel *)articleViewModel;

@end

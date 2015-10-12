//
//  CommentCell.h
//  MaiYa
//
//  Created by zxl on 15/9/10.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell
- (void)layoutCommentCellSubviewsByCommentViewModel:(CommentViewModel *)viewModel;
@end

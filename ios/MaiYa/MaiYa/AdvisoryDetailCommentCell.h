//
//  AdvisoryDetailCommentCell.h
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryDetailCommentCell : UITableViewCell

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *starBtnsArr;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

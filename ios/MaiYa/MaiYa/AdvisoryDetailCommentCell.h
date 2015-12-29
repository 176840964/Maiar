//
//  AdvisoryDetailCommentCell.h
//  MaiYa
//
//  Created by zxl on 15/9/9.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryDetailCommentCell : UITableViewCell <UITextViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *starBtnsArr;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (copy, nonatomic) NSString *selectedStarCountStr;

@property (copy, nonatomic) TapViewHandler tapCommitCommentHandler;

@end
//
//  MessageModel.h
//  MaiYa
//
//  Created by zxl on 15/10/20.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *status;
@end

@interface MessageViewModel : NSObject

@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *contentStr;
@property (copy, nonatomic) NSString *timeStr;
@property (strong, nonatomic) UIColor *textColor;

- (instancetype)initWithMessageModel:(MessageModel *)model;

@end

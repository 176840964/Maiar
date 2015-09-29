//
//  CommentModel.h
//  MaiYa
//
//  Created by zxl on 15/9/29.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface CommentModel : BaseModel
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *star;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *username;

@end

@interface CommentViewModel : NSObject
@property (copy, nonatomic) NSString *cidStr;
@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *contentStr;
@property (strong, nonatomic) NSNumber *starNum;
@property (copy, nonatomic) NSString *ctimeStr;
@property (copy, nonatomic) NSString *usernameStr;

- (instancetype) initWithCommentModel:(CommentModel *)model;
@end

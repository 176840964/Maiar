//
//  FocusModel.h
//  MaiYa
//
//  Created by zxl on 15/9/22.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel
@property (copy, nonatomic) NSString *aid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *abstract;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *read;
@property (copy, nonatomic) NSString *praise;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *head;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *type;
@end


@interface ArticleViewModel : NSObject
@property (copy, nonatomic) NSString *aidStr;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *abstractStr;
@property (strong, nonatomic) NSURL *imgUrl;
@property (strong, nonatomic) NSURL *url;
@property (copy, nonatomic) NSString *readStr;
@property (copy, nonatomic) NSString *praiseStr;
@property (copy, nonatomic) NSString *ctimeStr;
@property (copy, nonatomic) NSString *nickStr;
@property (strong, nonatomic) NSURL *headUrl;
@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *typeStr;

- (instancetype)initWithArticleModel:(ArticleModel *)model;

@end
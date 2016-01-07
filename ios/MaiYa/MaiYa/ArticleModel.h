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
@property (copy, nonatomic) NSString *digest;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *read;
@property (copy, nonatomic) NSString *praise;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *head;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *share_url;
@end


@interface ArticleViewModel : NSObject
@property (copy, nonatomic) NSString *aidStr;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *digestStr;
@property (copy, nonatomic) NSString *defulteImgStr;
@property (strong, nonatomic) NSURL *imgUrl;
@property (strong, nonatomic) NSURL *url;
@property (copy, nonatomic) NSString *readStr;
@property (copy, nonatomic) NSString *praiseStr;
@property (copy, nonatomic) NSString *timestampStr;
@property (copy, nonatomic) NSString *nickStr;
@property (strong, nonatomic) NSURL *headUrl;
@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *typeStr;
@property (copy, nonatomic) NSString *shareUrlStr;

- (instancetype)initWithArticleModel:(ArticleModel *)model;

@end
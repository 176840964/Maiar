//
//  ArticleDetailModel.h
//  MaiYa
//
//  Created by zxl on 15/9/29.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleDetailModel : BaseModel
@property (copy, nonatomic) NSString *aid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *read;
@property (copy, nonatomic) NSString *praise;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *head;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *introduce;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *utype;

@end

@interface ArticleDetailViewModel : NSObject

@property (copy, nonatomic) NSString *aidStr;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *contentStr;
@property (copy, nonatomic) NSString *readStr;
@property (copy, nonatomic) NSString *praiseStr;
@property (copy, nonatomic) NSString *ctimeStr;
@property (copy, nonatomic) NSString *uidStr;
@property (copy, nonatomic) NSString *nickStr;
@property (copy, nonatomic) NSString *headStr;
@property (copy, nonatomic) NSString *genderStr;
@property (copy, nonatomic) NSString *introduceStr;
@property (copy, nonatomic) NSString *typeStr;
@property (copy, nonatomic) NSString *utypeStr;

- (instancetype)initWithArticleDetailModel:(ArticleDetailModel *)model;


@end

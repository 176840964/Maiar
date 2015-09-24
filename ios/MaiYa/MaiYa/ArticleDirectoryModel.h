//
//  ArticleDirectoryModel.h
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleDirectoryModel : BaseModel

@property (strong, nonatomic) NSNumber *type;
@property (strong, nonatomic) NSArray *data;

@end

@interface ArticleDirectoryViewModel : NSObject
@property (strong, nonatomic) NSNumber *typeNum;
@property (strong, nonatomic) NSArray *dataArr;

- (instancetype)initWithArticleDirectoryModel:(ArticleDirectoryModel *)model;

@end

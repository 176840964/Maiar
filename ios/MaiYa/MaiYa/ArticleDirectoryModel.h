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
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSArray *dataArr;

- (instancetype)initWithArticleDirectoryModel:(ArticleDirectoryModel *)model;

@end

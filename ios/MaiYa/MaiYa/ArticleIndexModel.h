//
//  ArticleIndexModel.h
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleIndexModel : BaseModel
@property (copy, nonatomic) NSString *aid;
@property (copy, nonatomic) NSString *ztitle;
@property (copy, nonatomic) NSString *share_url;
@end

@interface ArticleIndexViewModel : NSObject
@property (copy, nonatomic) NSString *aidStr;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *shareUrlStr;

- (instancetype)initWithAritcleIndexModel:(ArticleIndexModel *)model;
@end

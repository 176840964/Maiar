//
//  ArticleDirectoryModel.m
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ArticleDirectoryModel.h"
#import "ArticleIndexModel.h"

@implementation ArticleDirectoryModel

@end

@implementation ArticleDirectoryViewModel

- (instancetype)initWithArticleDirectoryModel:(ArticleDirectoryModel *)model {
    if (self = [super init]) {
        self.typeStr = model.type.stringValue;
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *dic in model.data) {
            ArticleIndexModel *model = [[ArticleIndexModel alloc] initWithDic:dic];
            ArticleIndexViewModel *viewModel = [[ArticleIndexViewModel alloc] initWithAritcleIndexModel:model];
            
            [arr addObject:viewModel];
        }
        
        self.dataArr = [NSArray arrayWithArray:arr];
    }
    
    return self;
}

@end

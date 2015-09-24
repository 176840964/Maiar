//
//  SquareModel.m
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "SquareModel.h"
#import "ArticleModel.h"

@implementation SquareModel

@end

@implementation SquareViewModel

- (instancetype)initWithSquareModel:(SquareModel *)squareModel {
    if (self = [super init]) {
        {//focus
            NSMutableArray *fArr = [NSMutableArray new];
            for (NSDictionary *dic in squareModel.focus) {
                ArticleModel *model = [[ArticleModel alloc] initWithDic:dic];
                ArticleViewModel *viewModel = [[ArticleViewModel alloc] initWithArticleModel:model];
                
                [fArr addObject:viewModel];
            }
            self.focusArr = [NSArray arrayWithArray:fArr];
        }
        {//sentence
            SentenceModel *model = [[SentenceModel alloc] initWithDic:squareModel.sentence];
            self.sentenceViewModel = [[SentenceViewModel alloc] initWithSentenceModel:model];
        }
        {//astrology
            ArticleDirectoryModel *model = [[ArticleDirectoryModel alloc] initWithDic:squareModel.astrology];
            self.astrologyViewModel = [[ArticleDirectoryViewModel alloc] initWithArticleDirectoryModel:model];
        }
        {//tarlow
            ArticleDirectoryModel *model = [[ArticleDirectoryModel alloc] initWithDic:squareModel.tarlow];
            self.tarlowViewModel = [[ArticleDirectoryViewModel alloc] initWithArticleDirectoryModel:model];
        }
        {//zhouyi
            ArticleDirectoryModel *model = [[ArticleDirectoryModel alloc] initWithDic:squareModel.zhouyi];
            self.zhouyiViewModel = [[ArticleDirectoryViewModel alloc] initWithArticleDirectoryModel:model];
        }
        
    }
    
    return self;
}

@end

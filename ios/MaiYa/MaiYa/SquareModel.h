//
//  SquareModel.h
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"
#import "SentenceModel.h"
#import "ArticleDirectoryModel.h"

@interface SquareModel : BaseModel

@property (strong, nonatomic) NSArray *focus;
@property (strong, nonatomic) NSDictionary *sentence;
@property (strong, nonatomic) NSDictionary *astrology;
@property (strong, nonatomic) NSDictionary *tarlow;
@property (strong, nonatomic) NSDictionary *zhouyi;

@end

@interface SquareViewModel : NSObject
@property (strong, nonatomic) NSArray *focusArr;
@property (strong, nonatomic) SentenceViewModel *sentenceViewModel;
@property (strong, nonatomic) ArticleDirectoryViewModel *astrologyViewModel;
@property (strong, nonatomic) ArticleDirectoryViewModel *tarlowViewModel;
@property (strong, nonatomic) ArticleDirectoryViewModel *zhouyiViewModel;

- (instancetype)initWithSquareModel:(SquareModel *)squareModel;

@end

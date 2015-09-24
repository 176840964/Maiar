//
//  SentenceModel.h
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface SentenceModel : BaseModel

@property (copy, nonatomic) NSString *content;

@end

@interface SentenceViewModel : NSObject

@property (copy, nonatomic) NSString *contentStr;

- (instancetype)initWithSentenceModel:(SentenceModel *)model;

@end

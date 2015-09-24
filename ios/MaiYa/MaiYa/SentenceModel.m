//
//  SentenceModel.m
//  MaiYa
//
//  Created by zxl on 15/9/24.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "SentenceModel.h"

@implementation SentenceModel

@end

@implementation SentenceViewModel

- (instancetype)initWithSentenceModel:(SentenceModel *)model {
    if (self = [super init]) {
        self.contentStr = model.content;
    }
    
    return self;
}

@end

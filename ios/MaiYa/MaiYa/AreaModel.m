//
//  AreaModel.m
//  MaiYa
//
//  Created by zxl on 15/10/15.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if ([super initWithDic:dic]) {
        self.aid = [dic objectForKey:@"id"];
    }
    
    return self;
}

@end

@implementation AreaViewModel

- (instancetype)initWithAreaModel:(AreaModel *)model {
    if (self = [super init]) {
        self.areaIdStr = [model.aid stringValue];
        self.areaNameStr = [model.name stringValue];
        self.areaOrderStr = [model.order stringValue];
    }
    
    return self;
}

@end

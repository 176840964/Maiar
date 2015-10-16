//
//  AreaModel.h
//  MaiYa
//
//  Created by zxl on 15/10/15.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface AreaModel : BaseModel

@property (copy, nonatomic) NSString *aid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;

@end

@interface AreaViewModel : NSObject
@property (copy, nonatomic) NSString *areaIdStr;
@property (copy, nonatomic) NSString *areaNameStr;
@property (copy, nonatomic) NSString *areaOrderStr;

- (instancetype)initWithAreaModel:(AreaModel *)model;

@end

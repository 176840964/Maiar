//
//  FocusModel.h
//  MaiYa
//
//  Created by zxl on 15/9/22.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel
@property (copy, nonatomic) NSString *aid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *abstract;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *read;
@property (copy, nonatomic) NSString *praise;
@property (copy, nonatomic) NSString *ctime;
@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *head;
@property (strong, nonatomic) NSNumber *uid;
@property (strong, nonatomic) NSNumber *type;
@end

//
//  PlazaDetailViewController.h
//  MaiYa
//
//  Created by zxl on 15/9/1.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, PlazaDetailParaType) {
    PlazaDetailParaTypeOfUrl,//url
    PlazaDetailParaTypeOfArticle//文章id
};

@interface PlazaDetailViewController : BaseViewController

@property (assign, nonatomic) PlazaDetailParaType type;
@property (copy, nonatomic) NSString *catIndexStr;
@property (copy ,nonatomic) NSString *articleStr;
@property (strong, nonatomic) NSURL *url;
@end

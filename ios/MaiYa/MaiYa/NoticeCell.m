//
//  NoticeCell.m
//  MaiYa
//
//  Created by zxl on 15/8/25.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NoticeCell.h"

@interface NoticeCell ()
@property (nonatomic, weak) IBOutlet UILabel *titleLab;
@property (nonatomic, weak) IBOutlet UILabel *dateLab;
@end

@implementation NoticeCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.contentView.backgroundColor = [UIColor whiteColor];
//        
//        self.titleLab = [[UILabel alloc] init];
//        self.titleLab.backgroundColor = [UIColor clearColor];
//    }
//    
//    return self;
//}

- (void)layoutNoticCellSubviewsByDic:(NSDictionary*)dic {
    self.titleLab.text = [dic objectForKey:@"title"];
    self.dateLab.text = [dic objectForKey:@"date"];
    self.contentTextView.text = [dic objectForKey:@"content"];
    
    [super updateConstraints];
}

@end

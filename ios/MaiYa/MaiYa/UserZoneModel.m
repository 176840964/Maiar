//
//  UserZoneModel.m
//  MaiYa
//
//  Created by zxl on 15/9/29.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserZoneModel.h"

@implementation UserZoneModel


@end

@implementation UserZoneViewModel

- (instancetype)initWithUserZoneModel:(UserZoneModel *)model {
    if (self = [super init]) {
        if ([model.gender isEqualToString:@"1"]) {
            self.sexImage = [UIImage imageNamed:@"man2"];
        } else {
            self.sexImage = [UIImage imageNamed:@"woman2"];
        }
        
        self.nickStr = [model.nick stringValue];
        self.introduceStr = [model.introduce stringValue];
        self.headUrl = [NSURL URLWithString:[model.head stringValue]];
        self.backgroundUrl = [NSURL URLWithString:[model.background stringValue]];
        self.workAgeStr = [model.age stringValue];
        self.sharedArticleCountStr = [model.share stringValue];
        self.commentCountStr = [model.commentnum stringValue];
        self.commentAllStr = [model.commentall stringValue];
        
        NSMutableArray *workTypesArr = [NSMutableArray new];
        NSArray *typesArr = [model.type componentsSeparatedByString:@"/"];
        for (NSString *string in typesArr) {
            UIColor *color = nil;
            if ([string isEqualToString:@"占星"]) {
                color = [UIColor colorWithHexString:@"#3ac5f9"];
            } else if ([string isEqualToString:@"塔罗"]) {
                color = [UIColor colorWithHexString:@"#8bc81f"];
            } else {
                color = [UIColor colorWithHexString:@"#ff9c00"];
            }
            
            NSDictionary *dic = @{@"text": [NSString stringWithFormat:@"#%@", string],
                                  @"bgColor": color,
                                  @"font": [UIFont systemFontOfSize:10]};
            [workTypesArr addObject:dic];
        }
        self.workTypesArr = [NSArray arrayWithArray:workTypesArr];
        
        self.moneyPerHourStr = model.hour_money;
        self.lonStr = model.longitude;
        self.latStr = model.latitude;
        self.isOpenImmediate = [model.immediate isEqualToString:@"2"];
        
        self.balanceStr = model.balance;
        self.incomeStr = model.income;
        self.withdrawalsStr = model.withdrawals;
        self.realNameStr = model.idname;
        self.isIdentification = [model.id_status isEqualToString:@"1"];
        self.soonMoneyStr = [model.soon_money stringValue];
        self.isCollected = [model.collect isEqualToNumber:[NSNumber numberWithInteger:1]];
        
        ArticleModel *article = [[ArticleModel alloc] initWithDic:model.article];
        self.articleViewModel = [[ArticleViewModel alloc] initWithArticleModel:article];
        
        CommentModel *comment = [[CommentModel alloc] initWithDic:model.comment];
        self.commentViewModel = [[CommentViewModel alloc] initWithCommentModel:comment];
        
        NSMutableArray *workTimeStatusArr = [NSMutableArray new];
        NSArray *timeArr = [[model.time stringValue] componentsSeparatedByString:@","];
        for (NSInteger i = 0; i < timeArr.count; ++i) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            
            NSString *weekStr = [CustomTools dateStringFromUnixTimestamp:model.today.integerValue + 3600 * 24 * i withFormatString:@"e"];
            weekStr = [CustomTools weekStringFormIndex:weekStr.integerValue];
            [dic setValue:weekStr forKey:@"week"];
            
            NSString *dateStr = [CustomTools dateStringFromUnixTimestamp:model.today.integerValue + 3600 * 24 * i withFormatString:@"MM.dd"];
            [dic setValue:dateStr forKey:@"date"];
            
            NSString *string = [timeArr objectAtIndex:i];
            for (NSInteger j = 0; j < string.length; ++j) {
                NSString *key = @"";
                NSString *title = @"";
                switch (j) {
                    case 0:
                        key = @"am";
                        title = @" 上";
                        break;
                    case 1:
                        key = @"pm";
                        title = @" 下";
                        break;
                    default:
                        key = @"night";
                        title = @" 晚";
                        break;
                }
                
                UIColor *color = nil;
                UIColor *titleColor = nil;
                NSString *subStr = [string substringWithRange:NSMakeRange(j, 1)];
                switch (subStr.integerValue) {
                    case 1:
                        color = [UIColor colorWithHexString:@"#7bd313"];
                        titleColor = [UIColor whiteColor];
                        break;
                    case 2:
                        color = [UIColor colorWithHexString:@"#17b5ff"];
                        titleColor = [UIColor whiteColor];
                        break;
                    default:
                        color = [UIColor colorWithHexString:@"#e5edf4"];
                        titleColor = [UIColor colorWithHexString:@"#a8aaac"];
                        break;
                }
                
                NSDictionary *infoDic = @{@"title": title, @"bgColor": color, @"titleColor": titleColor};
                [dic setValue:infoDic forKey:key];
            }
            
            [workTimeStatusArr addObject:dic];
        }
        
        self.workTimeStatusArr = [NSArray arrayWithArray:workTimeStatusArr];
    }
    
    return self;
}

@end

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
        self.usernameStr = model.username;
        
        if ([model.gender isEqualToString:@"1"]) {
            self.sexStr = @"男";
            self.sexImage = [UIImage imageNamed:@"man3"];
        } else {
            self.sexStr = @"女";
            self.sexImage = [UIImage imageNamed:@"woman3"];
        }
        
        self.nickStr = [model.nick stringValue];
        self.introduceStr = [model.introduce stringValue];
        self.headUrl = [NSURL URLWithString:[model.head stringValue]];
        self.topImageUrl = [NSURL URLWithString:[model.background stringValue]];
        self.sharedArticleCountStr = [NSString stringWithFormat:@"(%@)", [model.share stringValue]];
        
        self.nickAndWorkAgeStr = [NSString stringWithFormat:@"%@ | %@", [model.nick stringValue], [model.age stringValue]];
        
        NSString *nickAndAgeStr = [NSString stringWithFormat:@"%@(%@)", [model.nick stringValue], [model.age stringValue]];
        self.nickAndWorkAgeAttributedStr = [[NSMutableAttributedString alloc] initWithString:nickAndAgeStr];
        NSRange range = [nickAndAgeStr rangeOfString:@"("];
        [self.nickAndWorkAgeAttributedStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0, range.location)];
        [self.nickAndWorkAgeAttributedStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.5], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#8898a5"]} range:NSMakeRange(range.location, nickAndAgeStr.length - range.location)];
        
        self.commentAllOnlyNumStr = [model.commentall stringValue];
        self.commentAllStr = [NSString stringWithFormat:@"总评价%@", [model.commentall stringValue]];
        self.commentNumStr = [NSString stringWithFormat:@"(%@次)", [model.commentnum stringValue]];
        
        NSString *commentStr = [NSString stringWithFormat:@"总评价%@(%@次)", [model.commentall stringValue], [model.commentnum stringValue]];
        range = [commentStr rangeOfString:@"("];
        self.commentStr = [[NSMutableAttributedString alloc] initWithString:commentStr];
        [self.commentStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.5]} range:NSMakeRange(0, range.location)];
        [self.commentStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#8898a5"]} range:NSMakeRange(range.location, commentStr.length - range.location)];
        
        self.commentCountStr = [NSString stringWithFormat:@"(%@)", [model.commentnum stringValue]];
        
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
        
        self.moneyPerHourStr = [NSString stringWithFormat:@"%@/小时", [model.hour_money stringValue]];
        self.lonStr = [model.longitude stringValue];
        self.latStr = [model.latitude stringValue];
        self.distanceStr = [model.distance stringValue];
        self.isOpenImmediate = [model.immediate isEqualToString:@"2"];
        
        self.balanceStr = [model.balance stringValue];
        self.incomeStr = [model.income stringValue];
        self.withdrawalsStr = [model.withdrawals stringValue];
        self.realNameStr = [model.idname stringValue];
        self.isIdentification = [model.id_status isEqualToString:@"1"];
        self.soonMoneyStr = [model.soon_money stringValue];
        self.isCollected = [model.collect_is isEqualToNumber:[NSNumber numberWithInteger:1]];
        self.beCollectedCountStr = [model.collect stringValue];
        
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
        
        self.todayTimestampStr = model.today;
    }
    
    return self;
}

@end

//
//  UserZoneModel.h
//  MaiYa
//
//  Created by zxl on 15/9/29.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserInfoModel.h"
#import "CommentModel.h"
#import "ArticleModel.h"

@interface UserZoneModel : UserInfoModel
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *introduce;
@property (copy, nonatomic) NSString *background;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *share;
@property (copy, nonatomic) NSString *commentnum;
@property (copy, nonatomic) NSString *commentall;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *hour_money;
@property (copy, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *immediate;
@property (copy, nonatomic) NSString *balance;
@property (copy, nonatomic) NSString *income;
@property (copy, nonatomic) NSString *withdrawals;
@property (copy, nonatomic) NSString *idname;
@property (copy, nonatomic) NSString *id_status;
@property (copy, nonatomic) NSString *distance;
@property (copy, nonatomic) NSString *soon_money;
@property (strong, nonatomic) NSDictionary *article;
@property (copy, nonatomic) NSString *today;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSDictionary *comment;
@property (strong, nonatomic) NSNumber *collect_is;
@property (copy, nonatomic) NSString *collect;

@end

@interface UserZoneViewModel : UserInfoViewModel

@property (copy, nonatomic) NSString *usernameStr;//手机号
@property (copy, nonatomic) NSString *introduceStr;//自我介绍
@property (strong, nonatomic) NSURL *topImageUrl;//背景图地址
@property (copy, nonatomic) NSString *nickAndWorkAgeStr;//时间和工作年限
@property (copy, nonatomic) NSString *sharedArticleCountStr;//分享文章数量
@property (strong, nonatomic) NSMutableAttributedString *commentStr;//评论数量
@property (copy, nonatomic) NSString *commentCountStr;
@property (strong, nonatomic) NSArray *workTypesArr;//类型
@property (copy, nonatomic) NSString *moneyPerHourStr;//每小时收费金额
@property (copy, nonatomic) NSString *lonStr;//经度
@property (copy, nonatomic) NSString *latStr;//纬度
@property (copy, nonatomic) NSString *distanceStr;//获取用户与其他用户直接距离
@property (assign, nonatomic) BOOL isOpenImmediate;//即时咨询：1 关闭 2开启
@property (copy, nonatomic) NSString *balanceStr;//账户余额
@property (copy, nonatomic) NSString *incomeStr;//累计收入
@property (copy, nonatomic) NSString *withdrawalsStr;//累计提现
@property (copy, nonatomic) NSString *realNameStr;//身份证姓名
@property (assign, nonatomic) BOOL isIdentification;//是否实名认证
@property (copy, nonatomic) NSString *soonMoneyStr;//即将到账金额
@property (copy, nonatomic) NSString *todayTimestampStr;//今天0点时间挫
@property (strong, nonatomic) NSArray *workTimeStatusArr;//咨询师7天的预约状态
@property (assign, nonatomic) BOOL isCollected;//是否收藏
@property (copy, nonatomic) NSString *beCollectedCountStr;
@property (strong, nonatomic) ArticleViewModel *articleViewModel;//分享文章
@property (strong, nonatomic) CommentViewModel *commentViewModel;//最新评论

- (instancetype)initWithUserZoneModel:(UserZoneModel *)model;

@end

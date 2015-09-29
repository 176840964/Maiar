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
@property (strong, nonatomic) NSNumber *today;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSDictionary *comment;
@property (strong, nonatomic) NSNumber *collect;

@end

@interface UserZoneViewModel : UserInfoViewModel

@property (copy, nonatomic) NSString *introduceStr;
@property (strong, nonatomic) NSURL *backgroundUrl;
@property (copy, nonatomic) NSString *ageStr;
@property (copy, nonatomic) NSString *shareStr;
@property (copy, nonatomic) NSString *commentnumStr;
@property (copy, nonatomic) NSString *commentallStr;
@property (copy, nonatomic) NSString *typeStr;
@property (copy, nonatomic) NSString *hourMoneyStr;
@property (strong, nonatomic) NSNumber *longitudeNum;
@property (strong, nonatomic) NSString *latitudeNum;
@property (copy, nonatomic) NSString *immediateStr;
@property (copy, nonatomic) NSString *balanceStr;
@property (copy, nonatomic) NSString *incomeStr;
@property (copy, nonatomic) NSString *withdrawalsStr;
@property (copy, nonatomic) NSString *idnameStr;
@property (assign, nonatomic) BOOL *isIdentification;//是否实名认证
@property (copy, nonatomic) NSString *soonMoneyStr;
@property (copy, nonatomic) NSString *todayStr;
@property (copy, nonatomic) NSString *timeStr;
@property (copy, nonatomic) NSString *isCollected;//是否收藏
@property (strong, nonatomic) ArticleViewModel *articleViewModel;
@property (strong, nonatomic) CommentViewModel *commentViewModel;

- (instancetype)initWithUserZoneModel:(UserZoneModel *)model;

@end

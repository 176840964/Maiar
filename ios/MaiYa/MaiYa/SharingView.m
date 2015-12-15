//
//  SharingView.m
//  MaiYa
//
//  Created by zxl on 15/12/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "SharingView.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"

@interface SharingView()
@property (strong, nonatomic) UIControl *markControl;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) NSMutableArray *sharingPathArr;
@end

@implementation SharingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _markControl = [UIControl newAutoLayoutView];
        _markControl.backgroundColor = [UIColor blackColor];
        _markControl.alpha = 0.0;
        [_markControl addTarget:self action:@selector(onTapCancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_markControl];
        [_markControl autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_markControl autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_markControl autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_markControl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_bgView autoSetDimension:ALDimensionHeight toSize:171];
        [_bgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_markControl];
        
        _cancelBtn = [UIButton newAutoLayoutView];
        _cancelBtn.backgroundColor = [UIColor colorWithR:114 g:133 b:144];
        _cancelBtn.cornerRadius = 4;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
        [_cancelBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(onTapCancel) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_cancelBtn];
        [_cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:26];
        [_cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:26];
        [_cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:26];
        [_cancelBtn autoSetDimension:ALDimensionHeight toSize:44];
        
        [self setupSharingPathArr];
    }
    
    return self;
}

- (void)showing {
    self.hidden = NO;
    [UIView animateWithDuration:.25 animations:^{
        self.markControl.alpha = .3;
        self.bgView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bgView.bounds));
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 
- (void)setupSharingPathArr {
    if (nil == _sharingPathArr) {
        _sharingPathArr = [NSMutableArray new];
    } else {
        [_sharingPathArr removeAllObjects];
    }
    
    if ([WXApi isWXAppInstalled]) {
        NSDictionary *wxDic = @{@"title": @"微信", @"icon": @"sharing_wx"};
        [_sharingPathArr addObject:wxDic];
        
        NSDictionary *frinedLineDic = @{@"title": @"朋友圈", @"icon": @"sharing_pyq"};
        [_sharingPathArr addObject:frinedLineDic];
    }

    if ([QQApiInterface isQQInstalled]) {
        NSDictionary *qqDic = @{@"title": @"QQ好友", @"icon": @"sharing_qq"};
        [_sharingPathArr addObject:qqDic];
        
        NSDictionary *zoneDic = @{@"title": @"QQ空间", @"icon": @"sharing_zone"};
        [_sharingPathArr addObject:zoneDic];
    }

    NSDictionary *weiboDic = @{@"title": @"新浪微博", @"icon": @"sharing_wb"};
    [_sharingPathArr addObject:weiboDic];
    
    for (NSInteger index = 0; index < self.sharingPathArr.count; index++) {
        NSDictionary *dic = [self.sharingPathArr objectAtIndex:index];
        [self setupSharingBtnWithTitle:[dic objectForKey:@"title"] iconStr:[dic objectForKey:@"icon"] index:index];
    }
}

- (void)onTapCancel {
    [UIView animateWithDuration:.25 animations:^{
        self.markControl.alpha = 0;
        self.bgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)setupSharingBtnWithTitle:(NSString *)titleStr iconStr:(NSString *)iconStr index:(NSInteger)index{
    CGFloat width = CGRectGetWidth(self.bounds) / self.sharingPathArr.count;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(width * index + (width - 43) / 2.0, 18, 43, 43 + 9 + 10);
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#3b4143"] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(52, -43, 0, 0)];
    [btn setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 19, 0)];
    [btn addTarget:self action:@selector(onTapBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:btn];
}

- (void)onTapBtn:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"微信"]) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = self.titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrlStr;
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:self.titleStr image:[UIImage imageNamed:@"aboutIcon"] location:nil urlResource:nil presentedController:self.parentController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    } else if ([btn.titleLabel.text isEqualToString:@"朋友圈"]) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.titleStr;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrlStr;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:self.titleStr image:[UIImage imageNamed:@"aboutIcon"] location:nil urlResource:nil presentedController:self.parentController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    } else if ([btn.titleLabel.text isEqualToString:@"QQ好友"]) {
        [UMSocialData defaultData].extConfig.qqData.title = self.titleStr;
        [UMSocialData defaultData].extConfig.qqData.url = self.shareUrlStr;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:self.titleStr image:[UIImage imageNamed:@"aboutIcon"] location:nil urlResource:nil presentedController:self.parentController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    } else if ([btn.titleLabel.text isEqualToString:@"QQ空间"]) {
        [UMSocialData defaultData].extConfig.qzoneData.title = self.titleStr;
        [UMSocialData defaultData].extConfig.qzoneData.url = self.shareUrlStr;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:self.titleStr image:[UIImage imageNamed:@"aboutIcon"] location:nil urlResource:nil presentedController:self.parentController completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    } else if ([btn.titleLabel.text isEqualToString:@"新浪微博"]) {
        NSString *content = [NSString stringWithFormat:@"%@%@", self.titleStr, self.shareUrlStr];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:content image:[UIImage imageNamed:@"aboutIcon"] location:nil urlResource:nil presentedController:self.parentController completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }
}

@end

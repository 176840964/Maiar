//
//  WalletInfoView.h
//  MaiYa
//
//  Created by zxl on 15/10/14.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletInfoView : UIView
@property (weak, nonatomic) IBOutlet UICountingLabel *balanceLab;
@property (weak, nonatomic) IBOutlet UIImageView *comingSoonIcon;
@property (weak, nonatomic) IBOutlet UILabel *comingSoonMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *totalIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *totalWithdrawalsLab;
@end

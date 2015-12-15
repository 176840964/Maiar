//
//  SharingView.h
//  MaiYa
//
//  Created by zxl on 15/12/10.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharingView : UIView

@property (weak, nonatomic) UIViewController *parentController;
@property (copy, nonatomic) NSString *shareUrlStr;
@property (copy, nonatomic) NSString *titleStr;
- (void)showing;

@end

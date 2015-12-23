//
//  LoginBaseViewController.h
//  MaiYa
//
//  Created by zxl on 15/12/22.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginBaseViewController;

@protocol LoginBaseViewControllerDelegate <NSObject>

- (void)loginBaseViewControllerShowKeyboard:(LoginBaseViewController *)loginBaseViewController;
- (void)loginBaseViewControllerHiddenKeyboard:(LoginBaseViewController *)loginBaseViewController;

@end

@interface LoginBaseViewController : UIViewController <LoginBaseViewControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIControl *contentView;

@property (weak, nonatomic) id<LoginBaseViewControllerDelegate> delegate;

- (void)converScrollViewContentSizeWithButtonFrame:(CGRect)frame;

@end
//
//  UIViewController+BackBtnHandler.m
//  MaiYa
//
//  Created by zxl on 15/11/18.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "UIViewController+BackBtnHandler.h"

@implementation UIViewController (BackBtnHandler)

@end

@implementation UINavigationController (ShouldPopOnBackBtn)

#pragma mark - UINavigationBarDelegate
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item {
    if (self.viewControllers.count < navigationBar.items.count) {
        return YES;
    }
    
    bool shouldPop = YES;
    UIViewController *vc = [self topViewController];
    if ([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if (shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}

@end

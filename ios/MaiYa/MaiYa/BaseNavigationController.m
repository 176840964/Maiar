//
//  BaseNavigationController.m
//  MaiYa
//
//  Created by zxl on 15/8/20.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()
@property (nonatomic, weak)UIViewController* currentShowViewController;
@end

@implementation BaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (1 == navigationController.viewControllers.count) {
        self.currentShowViewController = nil;
    } else {
        self.currentShowViewController = viewController;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer]) {
        return [self.currentShowViewController isEqual:self.topViewController];
    }
    
    return YES;
}
@end

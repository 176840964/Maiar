//
//  EditPhotoView.h
//  MaiYa
//
//  Created by zxl on 15/12/16.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditPhotoViewDelegate;

@interface EditPhotoView : UIView
@property (strong, nonatomic) UIImage *sourceImage;
@property (weak, nonatomic) id<EditPhotoViewDelegate> delegate;
@end

@protocol EditPhotoViewDelegate <NSObject>

- (void)editPhotoViewGestureRecognizerStateBegan:(EditPhotoView*)editPhotoView;
- (void)editPhotoViewGestureRecognizerStateEnded:(EditPhotoView*)editPhotoView;

@end
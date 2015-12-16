//
//  EditPhotoView.m
//  MaiYa
//
//  Created by zxl on 15/12/16.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "EditPhotoView.h"

@interface EditPhotoView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation EditPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 5.0;
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutPhotoViewByImage:(UIImage *)image {
    
    self.imageView.image = image;
    
    CGFloat aspect = image.size.height / image.size.width;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = aspect * width;
    
    self.imageView.frame = CGRectMake(CGRectGetMidX(self.bounds) - width / 2, CGRectGetMidY(self.bounds) - height / 2, width, height);
    
//    __weak typeof(self) weakSelf = self;
//    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:[UIImage imageNamed:@"order_car_photo"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        
//        CGFloat aspect = image.size.height / image.size.width;
//        CGFloat width = CGRectGetWidth(weakSelf.bounds);
//        CGFloat height = aspect * width;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.imageView.image = image;
//            [UIView animateWithDuration:.25 animations:^{
//                weakSelf.imageView.frame = CGRectMake(CGRectGetMidX(self.bounds) - width / 2, CGRectGetMidY(self.bounds) - height / 2, width, height);
//            }];
//        });
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        //            blockImageView.image = [UIImage imageNamed:@"order_car_photo"];
//    }];
}

#pragma mark - UIScrollView
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
}

@end

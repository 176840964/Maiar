//
//  EditPhotoView.m
//  MaiYa
//
//  Created by zxl on 15/12/16.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "EditPhotoView.h"

static const CGFloat kMaxUIImageSize = 1024;

@interface EditPhotoView () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *imageView;

@property(nonatomic, assign) CGFloat minimumZoomScale;
@property(nonatomic, assign) CGFloat maximumZoomScale;

@property(nonatomic, assign) NSUInteger gestureCount;
@property(nonatomic, assign) CGFloat scale;
@property(nonatomic, assign) CGPoint scaleCenter;
@property(nonatomic, assign) CGPoint touchCenter;
@property(nonatomic, assign) CGPoint rotationCenter;

@end

@implementation EditPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 5.0;
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        [self setupGestureRecognizer];
    }
    return self;
}

- (void)setSourceImage:(UIImage *)sourceImage {
    if (sourceImage != _sourceImage) {
        _sourceImage = sourceImage;
        
        [self reset:NO];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            CGFloat aspect = _sourceImage.size.height / _sourceImage.size.width;
            CGSize size = CGSizeZero;
            if (aspect >= 1.0) {
                size = CGSizeMake(kMaxUIImageSize / aspect, kMaxUIImageSize);
            } else {
                size = CGSizeMake(kMaxUIImageSize, kMaxUIImageSize * aspect);
            }
            
            CGImageRef imageRef = [self newScaledImage:_sourceImage.CGImage withOrientation:_sourceImage.imageOrientation toSize:size withQuality:kCGInterpolationDefault];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationUp];
                CGImageRelease(imageRef);
            });
        });
    }
}

#pragma mark -
- (void)setupGestureRecognizer {
    
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.cancelsTouchesInView = NO;
    panRecognizer.delegate = self;
    [self addGestureRecognizer:panRecognizer];
    
    UIRotationGestureRecognizer* rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationRecognizer.cancelsTouchesInView = NO;
    rotationRecognizer.delegate = self;
    [self addGestureRecognizer:rotationRecognizer];
    
    UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchRecognizer.cancelsTouchesInView = NO;
    pinchRecognizer.delegate = self;
    [self addGestureRecognizer:pinchRecognizer];
}

-(void)reset:(BOOL)animated
{
    CGFloat aspect = self.sourceImage.size.height/self.sourceImage.size.width;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = aspect * w;
    self.scale = 1;
    
    void (^doReset)(void) = ^{
        self.imageView.transform = CGAffineTransformIdentity;
        self.imageView.frame = CGRectMake(CGRectGetMidX(self.bounds) - w/2, CGRectGetMidY(self.bounds) - h/2,w,h);
    };
    if(animated) {
        //        self.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.25 animations:doReset completion:^(BOOL finished) {
            //            self.userInteractionEnabled = YES;
        }];
    } else {
        doReset();
    }
}

- (BOOL)handleGestureState:(UIGestureRecognizerState)state
{
    BOOL handle = YES;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            self.gestureCount++;
            if ([self.delegate respondsToSelector:@selector(editPhotoViewGestureRecognizerStateBegan:)]) {
                [self.delegate editPhotoViewGestureRecognizerStateBegan:self];
            }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            self.gestureCount--;
            handle = NO;
            if(self.gestureCount == 0) {
                CGFloat scale = self.scale;
                if(self.minimumZoomScale != 0 && self.scale < self.minimumZoomScale) {
                    scale = self.minimumZoomScale;
                } else if(self.maximumZoomScale != 0 && self.scale > self.maximumZoomScale) {
                    scale = self.maximumZoomScale;
                }
                if(scale != self.scale) {
                    CGFloat deltaX = self.scaleCenter.x-self.imageView.bounds.size.width/2.0;
                    CGFloat deltaY = self.scaleCenter.y-self.imageView.bounds.size.height/2.0;
                    
                    CGAffineTransform transform =  CGAffineTransformTranslate(self.imageView.transform, deltaX, deltaY);
                    transform = CGAffineTransformScale(transform, scale/self.scale , scale/self.scale);
                    transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
                    self.userInteractionEnabled = NO;
                    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        self.imageView.transform = transform;
                    } completion:^(BOOL finished) {
                        self.userInteractionEnabled = YES;
                        self.scale = scale;
                    }];
                    
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(editPhotoViewGestureRecognizerStateEnded:)]) {
                [self.delegate editPhotoViewGestureRecognizerStateEnded:self];
            }
            
        } break;
        default:
            break;
    }
    return handle;
}

#pragma mark - GestureRecognizer
- (void)handlePan:(UIPanGestureRecognizer*)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        CGPoint translation = [recognizer translationInView:self.imageView];
        CGAffineTransform transform = CGAffineTransformTranslate(self.imageView.transform, translation.x, translation.y);
        self.imageView.transform = transform;
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    }
}

- (void)handleRotation:(UIRotationGestureRecognizer*)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        if(recognizer.state == UIGestureRecognizerStateBegan){
            self.rotationCenter = self.touchCenter;
        }
        CGFloat deltaX = self.rotationCenter.x-self.imageView.bounds.size.width/2;
        CGFloat deltaY = self.rotationCenter.y-self.imageView.bounds.size.height/2;
        
        CGAffineTransform transform =  CGAffineTransformTranslate(self.imageView.transform,deltaX,deltaY);
        transform = CGAffineTransformRotate(transform, recognizer.rotation);
        transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
        self.imageView.transform = transform;
        
        recognizer.rotation = 0;
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        if(recognizer.state == UIGestureRecognizerStateBegan){
            self.scaleCenter = self.touchCenter;
        }
        CGFloat deltaX = self.scaleCenter.x-self.imageView.bounds.size.width/2.0;
        CGFloat deltaY = self.scaleCenter.y-self.imageView.bounds.size.height/2.0;
        
        CGAffineTransform transform =  CGAffineTransformTranslate(self.imageView.transform, deltaX, deltaY);
        transform = CGAffineTransformScale(transform, recognizer.scale, recognizer.scale);
        transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
        self.scale *= recognizer.scale;
        self.imageView.transform = transform;
        
        recognizer.scale = 1;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark Touches
- (void)handleTouches:(NSSet*)touches
{
    self.touchCenter = CGPointZero;
    if(touches.count < 2) return;
    
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch*)obj;
        CGPoint touchLocation = [touch locationInView:self.imageView];
        self.touchCenter = CGPointMake(self.touchCenter.x + touchLocation.x, self.touchCenter.y +touchLocation.y);
    }];
    self.touchCenter = CGPointMake(self.touchCenter.x/touches.count, self.touchCenter.y/touches.count);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

# pragma mark Image Transformation
- (CGImageRef)newScaledImage:(CGImageRef)source withOrientation:(UIImageOrientation)orientation toSize:(CGSize)size withQuality:(CGInterpolationQuality)quality
{
    CGSize srcSize = size;
    CGFloat rotation = 0.0;
    
    switch(orientation)
    {
        case UIImageOrientationUp: {
            rotation = 0;
        } break;
        case UIImageOrientationDown: {
            rotation = M_PI;
        } break;
        case UIImageOrientationLeft:{
            rotation = M_PI_2;
            srcSize = CGSizeMake(size.height, size.width);
        } break;
        case UIImageOrientationRight: {
            rotation = -M_PI_2;
            srcSize = CGSizeMake(size.height, size.width);
        } break;
            
            
        default:
            break;
    }
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width,
                                                 size.height,
                                                 8, //CGImageGetBitsPerComponent(source),
                                                 0,
                                                 CGImageGetColorSpace(source),
                                                 CGImageGetBitmapInfo(source)
                                                 );
    
    CGContextSetInterpolationQuality(context, quality);
    CGContextTranslateCTM(context,  size.width/2,  size.height/2);
    CGContextRotateCTM(context,rotation);
    
    CGContextDrawImage(context, CGRectMake(-srcSize.width/2,
                                           -srcSize.height/2,
                                           srcSize.width,
                                           srcSize.height),
                       source);
    
    CGImageRef resultRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    return resultRef;
}

@end

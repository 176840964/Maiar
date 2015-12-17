//
//  EditTopImageViewController.m
//  MaiYa
//
//  Created by zxl on 15/12/16.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "EditTopImageViewController.h"
#import "EditPhotoView.h"

@interface EditTopImageViewController () <EditPhotoViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) EditPhotoView *editPhotoView;
@end

@implementation EditTopImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.editPhotoView.sourceImage = self.oriImage;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark -
- (EditPhotoView *)editPhotoView {
    if (_editPhotoView == nil) {
        _editPhotoView = [[EditPhotoView alloc] initWithFrame:self.view.bounds];
        _editPhotoView.delegate = self;
        [self.view insertSubview:_editPhotoView belowSubview:self.bgImageView];
    }
    
    return _editPhotoView;
}

- (UIImage *)getEndCuttingImage {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat minY = width * 47 / 75;
    CGFloat height = width / 3;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(self.editPhotoView.frame.size, NO, scale);
    [self.editPhotoView drawViewHierarchyInRect:self.editPhotoView.bounds afterScreenUpdates:YES];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(0 * scale, minY * scale, width * scale, height * scale);
    CGImageRef imageref = CGImageCreateWithImageInRect(viewImage.CGImage, rect);
    
    return [UIImage imageWithCGImage:imageref];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - NetWorking
- (void)uploadEditImage:(UIImage *)selectedImage {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] uploadImageForEditUserInfoWithUid:uid userInfoKey:@"background" image:selectedImage success:^(id responseObject) {
        NSLog(@"responseObject=======:%@", responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapOkBtn:(id)sender {
    UIImage *image = [self getEndCuttingImage];
    [self uploadEditImage:image];
}

- (IBAction)onTapCancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - EditPhotoViewDelegate
- (void)editPhotoViewGestureRecognizerStateBegan:(EditPhotoView*)editPhotoView {
    
}

- (void)editPhotoViewGestureRecognizerStateEnded:(EditPhotoView*)editPhotoView {
    
}

@end

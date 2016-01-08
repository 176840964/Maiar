//
//  RealInfoComfirmViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "RealInfoComfirmViewController.h"

@interface RealInfoComfirmViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollHeight;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIButton *idPositiveBtn;//正面
@property (weak, nonatomic) IBOutlet UIButton *idOppositeBtn;//反面
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (strong, nonatomic) UIImage *idCardPositiveImage;
@property (strong, nonatomic) UIImage *idCardOppositeImage;

@property (assign, nonatomic) BOOL isIdCardPositive;
@property (assign, nonatomic) NSInteger countIndex;
@property (strong, nonatomic) NSTimer *countTimer;

@end

@implementation RealInfoComfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.scrollHeight.constant = CGRectGetHeight([UIScreen mainScreen].bounds) - 64;
}

#pragma mark -
- (void)showKeyboard:(NSNotification *)notify {
    CGRect kbRect = [[notify.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect frame = [self.view convertRect:self.commitBtn.frame fromView:self.scrollView];
    if (CGRectGetMaxY(frame) > CGRectGetMinY(kbRect)) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64 + CGRectGetMaxY(frame) + 15 - CGRectGetMinY(kbRect));
    }
}

- (void)textFieldResignFirstResponder {
    [self.nameTextField resignFirstResponder];
    [self.idTextField resignFirstResponder];
    [self.msgTextField resignFirstResponder];
    
    self.scrollView.contentSize = self.scrollView.frame.size;
}

- (void)showPickerControllerWithType:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = type;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^{}];
    }
}

- (void)oneMinuteCountdown {
    self.msgBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.msgBtn setTitle:[NSString stringWithFormat:@"%zd", self.countIndex] forState:UIControlStateNormal];
    
    self.countTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)countdown {
    if (0 != self.countIndex) {
        self.countIndex --;
        [self.msgBtn setTitle:[NSString stringWithFormat:@"%zd", self.countIndex] forState:UIControlStateNormal];
    } else {
        [self setMessageCodeBtnNormalType];
    }
}

- (void)setMessageCodeBtnNormalType {
    [self.countTimer invalidate];
    
    self.msgBtn.backgroundColor = [UIColor colorWithHexString:@"#6db82a"];
    [self.msgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.msgBtn.titleLabel.font = [UIFont systemFontOfSize:15];
}

#pragma mark - Networking
- (void)editUserReal {
    [[HintView getInstance] showSimpleLoading];
    [[NetworkingManager shareManager] editUserRealInfoByInfoDic:@{@"uid": [UserConfigManager shareManager].userInfo.uidStr, @"idname": self.nameTextField.text, @"idcard": self.idTextField.text, @"yzm": self.msgTextField.text} imageDic:@{@"idimg_p": self.idCardPositiveImage, @"idimg_o": self.idCardOppositeImage} success:^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HintView getInstance] endSimpleLoading];
            [self performSegueWithIdentifier:@"ShowWithdrawalViewController" sender:self];
        });
        
    }];
}

#pragma mark - IBAction
- (IBAction)onTapCameraBtn:(id)sender {
    [self textFieldResignFirstResponder];
    
    UIButton *btn = (UIButton *)sender;
    self.isIdCardPositive = (btn.tag == 0);
    
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"相册选择", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? @"相机拍摄" : nil, nil];
    [sheet showInView:self.view];
}

- (IBAction)onTapSendMessage:(id)sender {
    if (self.countTimer.valid) {
        return;
    }
    
    [self textFieldResignFirstResponder];
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"getCode" params:@{@"uid": [UserConfigManager shareManager].userInfo.uidStr, @"type": @"3"} success:^(id responseObject) {
        
        [self.msgTextField becomeFirstResponder];
        self.msgBtn.backgroundColor = [UIColor lightGrayColor];
        self.countIndex = 60;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self oneMinuteCountdown];
        });
    }];
}

- (IBAction)onTapCommitBtn:(id)sender {
    [self textFieldResignFirstResponder];
    NSString *errMessage = @"";
    if (!self.nameTextField.text.isValid) {
        errMessage = @"请填写姓名";
    } else if (!self.idTextField.text.isValid) {
        errMessage = @"请填写身份证号";
    } else if (!self.msgTextField.text.isValid) {
        errMessage = @"请填写验证码";
    } else if (!self.idCardPositiveImage) {
        errMessage = @"请上传身份证正面照片";
    } else if (!self.idCardOppositeImage) {
        errMessage = @"请上传身份证反面照片";
    }
    
    if (errMessage.isValid) {
        [[HintView getInstance] presentMessage:errMessage isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:^{
            
        }];
    } else {
        [self editUserReal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIScrollViewDelegate
static CGFloat beginDragging = 0.0;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    beginDragging = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (beginDragging - scrollView.contentOffset.y > 15) {
        [self textFieldResignFirstResponder];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"相册选择"]) {
        [self showPickerControllerWithType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    } else if ([buttonTitle isEqualToString:@"相机拍摄"]) {
        [self showPickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (self.isIdCardPositive) {
        self.idCardPositiveImage = selectedImage;
        [self.idPositiveBtn setImage:selectedImage forState:UIControlStateNormal];
    } else {
        self.idCardOppositeImage = selectedImage;
        [self.idOppositeBtn setImage:selectedImage forState:UIControlStateNormal];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

@end

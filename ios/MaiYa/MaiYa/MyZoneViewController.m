//
//  MyZoneViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MyZoneViewController.h"
#import "UserZoneModel.h"
#import "ZoneWorkingTimeView.h"
#import "AbstractViewController.h"
#import "CommentViewController.h"
#import "SelectingServiceDateViewController.h"
#import "EditTopImageViewController.h"

@interface MyZoneViewController () <UIScrollViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *redHeartView;
@property (weak, nonatomic) IBOutlet UILabel *colletedCountLab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *workTypeLabsArr;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UILabel *pricePerHourLab;

@property (weak, nonatomic) IBOutlet UIButton *introduceSettingBtn;
@property (weak, nonatomic) IBOutlet UITextView *introduceTxtView;

@property (weak, nonatomic) IBOutlet UIButton *myShareSettingBtn;
@property (weak, nonatomic) IBOutlet UILabel *shareArticlesCountLab;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *articleDigestLab;
@property (weak, nonatomic) IBOutlet UILabel *articleDateLab;
@property (weak, nonatomic) IBOutlet UILabel *articleReadCountLab;
@property (weak, nonatomic) IBOutlet UILabel *articleGoodCountLab;

@property (weak, nonatomic) IBOutlet UIButton *workingTimeSettingBtn;
@property (weak, nonatomic) IBOutlet ZoneWorkingTimeView *workingTimeView;

@property (weak, nonatomic) IBOutlet UILabel *commentCountLab;
@property (weak, nonatomic) IBOutlet UILabel *commentDateLab;
@property (weak, nonatomic) IBOutlet UILabel *commentUserLab;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLab;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *commentStarArr;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) UserZoneViewModel *userZoneViewModel;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation MyZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomView.hidden = (ZoneViewControllerTypeOfMine == self.type);
    self.introduceSettingBtn.hidden = !self.bottomView.hidden;
    self.myShareSettingBtn.hidden = !self.bottomView.hidden;
    self.workingTimeSettingBtn.hidden = !self.bottomView.hidden;
    
    self.workTypeLabsArr = [self.workTypeLabsArr sortByUIViewOriginX];
    self.commentStarArr = [self.commentStarArr sortByUIViewOriginX];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getUserInfo];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat height = 671 + 20 + 107.0 / 320 * self.view.width + ((ZoneViewControllerTypeOfOther == self.type) ? 58 : 0);
    self.mainViewHeight.constant = height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"ShowAbstractViewController"]) {
        AbstractViewController *controller = segue.destinationViewController;
        controller.abstractStr = self.introduceTxtView.text;
    } else if ([segue.identifier isEqualToString:@"ShowCommentViewController"]) {
        CommentViewController *controller = segue.destinationViewController;
        controller.countStr = self.userZoneViewModel.commentNumStr;
        controller.allValueStr = self.userZoneViewModel.commentAllOnlyNumStr;
    } else if ([segue.identifier isEqualToString:@"ShowSelectingServiceDateViewController"]) {
        SelectingServiceDateViewController *controller = segue.destinationViewController;
        controller.masterId = self.cidStr;
    } else if ([segue.identifier isEqualToString:@"ShowEditImageViewController"]) {
        EditTopImageViewController *vc = segue.destinationViewController;
        vc.oriImage = self.selectedImage;
    }
}

#pragma mark - 
- (void)layoutWorkingTime {
    [self.topImageView setImageWithURL:self.userZoneViewModel.topImageUrl placeholderImage:[UIImage imageNamed:@"testZoneTopImage"]];
    self.locationLab.text = self.userZoneViewModel.distanceStr;
    
    CGRect rect = [self.locationLab textRectForBounds:self.locationLab.frame limitedToNumberOfLines:1];
    self.locationLab.width = CGRectGetWidth(rect);
    self.locationLab.x = self.view.width - self.locationLab.width - 8;
    self.locationImageView.x = self.locationLab.x - self.locationImageView.width;
    
    [self.headImageView setImageWithURL:self.userZoneViewModel.headUrl placeholderImage:[UIImage imageNamed:DefaultUserHeaderImage]];
    self.sexImageView.image = self.userZoneViewModel.sexImage;
    self.nameLab.text = self.userZoneViewModel.nickAndWorkAgeStr;
    
    self.colletedCountLab.text = self.userZoneViewModel.beCollectedCountStr;
    rect = [self.colletedCountLab textRectForBounds:self.colletedCountLab.frame limitedToNumberOfLines:1];
    self.colletedCountLab.width = CGRectGetWidth(rect);
    self.colletedCountLab.x = self.view.width - self.colletedCountLab.width - 12;
    self.redHeartView.x = self.colletedCountLab.x - self.redHeartView.width - 2;
    
    for (NSInteger index = 0; index < self.workTypeLabsArr.count; ++index) {
        UILabel *lab = [self.workTypeLabsArr objectAtIndex:index];
        if (index >= self.userZoneViewModel.workTypesArr.count) {
            lab.hidden = YES;
        } else {
            NSDictionary *dic = [self.userZoneViewModel.workTypesArr objectAtIndex:index];
            lab.hidden = NO;
            lab.text = [dic objectForKey:@"text"];
            lab.backgroundColor = [dic objectForKey:@"bgColor"];
            lab.font = [dic objectForKey:@"font"];
        }
    }
    self.commentLab.attributedText = self.userZoneViewModel.commentStr;
    self.pricePerHourLab.text = self.userZoneViewModel.moneyPerHourStr;
    
    self.introduceTxtView.text = self.userZoneViewModel.introduceStr;
    
    self.shareArticlesCountLab.text = self.userZoneViewModel.sharedArticleCountStr;
    [self.articleImageView setImageWithURL:self.userZoneViewModel.articleViewModel.imgUrl placeholderImage:[UIImage imageNamed:@"aboutIcon"]];
    self.articleTitleLab.text = self.userZoneViewModel.articleViewModel.titleStr;
    self.articleDigestLab.text = self.userZoneViewModel.articleViewModel.digestStr;
    self.articleDateLab.text = [CustomTools dateStringFromTodayUnixTimestamp:self.userZoneViewModel.todayTimestampStr.integerValue andOtherTimestamp:self.userZoneViewModel.articleViewModel.timestampStr.integerValue];
    self.articleReadCountLab.text = self.userZoneViewModel.articleViewModel.readStr;
    self.articleGoodCountLab.text = self.userZoneViewModel.articleViewModel.praiseStr;
    
    [self.workingTimeView layoutZoneWorkingTimeViewSubviewsByWorkTimeStatusArr:self.userZoneViewModel.workTimeStatusArr];
    
    self.commentCountLab.text = self.userZoneViewModel.commentCountStr;
    self.commentDateLab.text = self.userZoneViewModel.commentViewModel.ctimeStr;
    self.commentUserLab.text = self.userZoneViewModel.commentViewModel.usernameStr;
    self.commentContentLab.text = self.userZoneViewModel.commentViewModel.contentStr;
    [self layoutCommentStarByStarCountStr:self.userZoneViewModel.commentViewModel.starCountStr];
}

- (void)layoutCommentStarByStarCountStr:(NSString *)starCountStr {
    for (NSInteger index = 0; index < self.commentStarArr.count; ++index) {
        UIImageView* imgView = [self.commentStarArr objectAtIndex:index];
        if (index < starCountStr.integerValue) {
            imgView.image = [UIImage imageNamed:@"smallStar1"];
        } else {
            imgView.image = [UIImage imageNamed:@"smallStar0"];
        }
    }
}

- (void)showPickerControllerWithType:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = type;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

#pragma mark - Networking
- (void)getUserInfo {
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    [paramsDic setObject:self.cidStr forKey:@"cid"];
    if ([UserConfigManager shareManager].isLogin) {
        [paramsDic setObject:[UserConfigManager shareManager].userInfo.uidStr forKey:@"oid"];
    } else {
        NSString *longitude = [UserConfigManager shareManager].lonStr;
        NSString *latitude = [UserConfigManager shareManager].latStr;
        [paramsDic setObject:longitude forKey:@"longitude"];
        [paramsDic setObject:latitude forKey:@"latitude"];
    }
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userInfo" params:paramsDic success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        UserZoneModel *model = [[UserZoneModel alloc] initWithDic:resDic];
        self.userZoneViewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
        
        if (self.type == ZoneViewControllerTypeOfOther) {
            [UserConfigManager shareManager].createOrderViewModel.masterInfo = model;
            [UserConfigManager shareManager].createOrderViewModel.masterInfo.uid = self.cidStr;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutWorkingTime];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapSharingSettingBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowMySharingViewController" sender:self];
}

- (IBAction)onTapSharingMoreBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowMySharingViewController" sender:self];
}

- (IBAction)onTapNextBtn:(id)sender {
    if ([UserConfigManager shareManager].isLogin) {
        [self performSegueWithIdentifier:@"ShowSelectingServiceDateViewController" sender:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationOfShowingLogin" object:nil];
    }
}

- (IBAction)tapTopImageViewGestureRecognizer:(id)sender {
    if (self.type != ZoneViewControllerTypeOfMine) {
        return;
    }
    
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"相册选择", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? @"相机拍摄" : nil, nil];
    [sheet showInView:self.view];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.bottomView.hidden) {
        [UIView animateWithDuration:.5 animations:^{
            self.bottomView.transform = CGAffineTransformMakeTranslation(0, self.bottomView.height);
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.bottomView.hidden) {
        [UIView animateWithDuration:.5 animations:^{
            self.bottomView.transform = CGAffineTransformIdentity;
        }];
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
    self.selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ShowEditImageViewController" sender:self];
    }];
}

@end

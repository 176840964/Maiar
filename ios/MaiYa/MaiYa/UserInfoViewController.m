//
//  UserInfoViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"
#import "UserZoneModel.h"
#import "UserNameViewController.h"
#import "UserSexViewController.h"

@interface UserInfoViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UserZoneViewModel *userInfoViewModel;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getUserInfo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"ShowUserNameViewController"]) {
        UserNameViewController *controller = segue.destinationViewController;
        controller.nickStr = self.userInfoViewModel.nickStr;
    } else if ([segue.identifier isEqualToString:@"ShowUserSexViewController"]) {
        UserSexViewController *controller = segue.destinationViewController;
        controller.sexStr = self.userInfoViewModel.sexStr;
    }
}

#pragma mark - 
- (void)showActionInView {
    UIActionSheet* actionsheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                     otherButtonTitles:@"相册选择", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ?@"相机拍摄" : nil, nil];
    
    actionsheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionsheet showInView:self.view];
}

- (void)showPickerControllerWithType:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        if (self.imagePickerController == nil) {
            self.imagePickerController = [[UIImagePickerController alloc] init];
            self.imagePickerController.delegate = self;
            self.imagePickerController.sourceType = type;
            self.imagePickerController.allowsEditing = YES;
        }
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{
        }];
    }
}

- (void)getUserInfo {
    NSString *cid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userInfo" params:@{@"cid": cid} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        UserZoneModel *model = [[UserZoneModel alloc] initWithDic:resDic];
        self.userInfoViewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
        
        [UserConfigManager shareManager].userInfo.nickStr = self.userInfoViewModel.nickStr;
        [UserConfigManager shareManager].userInfo.sexImage = self.userInfoViewModel.sexImage;
        [UserConfigManager shareManager].userInfo.sexStr = self.userInfoViewModel.sexStr;
        [UserConfigManager shareManager].userInfo.headUrl = self.userInfoViewModel.headUrl;
        [[UserConfigManager shareManager] synchronize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)editUserHeadWithImage:(UIImage *)selectedImage {
    [[HintView getInstance] startLoadingMessage:@"照片上传中..."];
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] uploadImageForEditUserInfoWithUid:uid userInfoKey:@"head" image:selectedImage success:^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HintView getInstance] endLoadingMessage:@"照片上传成功" dismissTimeInterval:1 dismissBlock:^{
                [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
                }];
            }];
        });
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"UserInfoCell%zd", indexPath.row]];
    
    switch (indexPath.row) {
        case 0:
            [cell.imgView setImageWithURL:self.userInfoViewModel.headUrl placeholderImage:[UIImage imageNamed:@"defulteHead"]];
            break;
        case 1:
            cell.lab.text = self.userInfoViewModel.nickStr;
            break;
        case 2:
            cell.lab.text = self.userInfoViewModel.usernameStr;
            break;
        default:
            cell.lab.text = self.userInfoViewModel.sexStr;
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.row) {
        [self showActionInView];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* str = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"相册选择"]) {
        [self showPickerControllerWithType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    } else if ([str isEqualToString:@"相机拍摄"]) {
        [self showPickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self editUserHeadWithImage:selectedImage];
}

@end

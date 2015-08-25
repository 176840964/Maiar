//
//  UserInfoViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"

@interface UserInfoViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImage *selectedImage;
@end

@implementation UserInfoViewController

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
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:^{
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"UserInfoCell%zd", indexPath.row]];
    
    switch (indexPath.row) {
        case 0:
            cell.imgView.image = [UIImage imageNamed:@"login_bg"];
            break;
        case 1:
            cell.lab.text = @"zhangran";
            break;
        case 2:
            cell.lab.text = @"13911016821";
            break;
        default:
            cell.lab.text = @"男";
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
    self.selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

@end

//
//  EditTopImageViewController.m
//  MaiYa
//
//  Created by zxl on 15/12/16.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "EditTopImageViewController.h"
#import "EditPhotoView.h"

@interface EditTopImageViewController ()
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.editPhotoView layoutPhotoViewByImage:self.oriImage];
}

#pragma mark -
- (EditPhotoView *)editPhotoView {
    if (_editPhotoView == nil) {
        _editPhotoView = [[EditPhotoView alloc] initWithFrame:self.view.bounds];
        
        [self.view insertSubview:_editPhotoView belowSubview:self.bgImageView];
    }
    
    return _editPhotoView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction
- (IBAction)onTapOkBtn:(id)sender {
    
}

- (IBAction)onTapCancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

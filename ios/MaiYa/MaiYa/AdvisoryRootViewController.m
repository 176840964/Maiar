//
//  AdvisoryRootViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryRootViewController.h"
#import "CarouselCell.h"
#import "MastersListViewController.h"
#import "OrderModel.h"

@interface AdvisoryRootViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;

@property (weak, nonatomic) IBOutlet UIView *orderDateView;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLab;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLab;

@property (weak, nonatomic) IBOutlet UIView *orderInfoView;
@property (weak, nonatomic) IBOutlet UILabel *orderNameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNameLab;
@property (weak, nonatomic) IBOutlet UILabel *orderProblemLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderServiceModeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn1;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn2;

@property (strong, nonatomic) AdvisoryCatView *catView;
@property (assign, nonatomic) AdvisoryCatModel selectedCatModel;

@property (strong, nonatomic) OrderViewModel *orderViewModel;
@end

@implementation AdvisoryRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getCurentOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CarouselCell *cell = [[CarouselCell alloc] init];
    cell.frame = self.headerScrollView.bounds;
    [self.headerScrollView addSubview:cell];
    
    self.headerScrollView.contentSize = CGSizeMake(self.headerScrollView.width, self.headerScrollView.height);
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat btnWidth = (width - 5 * 2 - 6 * 3) / 4;
    CGFloat btnHeight = 26 / 17.0 * btnWidth;
    CGFloat height = 107 / 320.0 * width + 10 + 8 + 10 + btnHeight * 2 + 40 + 31 + 164;
    self.contentHeightConstraint.constant = height + 6;
}

#pragma mark -
- (void)layoutOrderViewByOrderViewModel:(OrderViewModel *)viewModel {
    self.orderDateLab.text = viewModel.timeStr;
    self.orderStatusLab.text = viewModel.statusStr;
    
    self.orderNameTitleLab.text = viewModel.nameTitleStr;
    self.orderNameLab.text = viewModel.nameStr;
    self.orderProblemLab.text = viewModel.problemStr;
    self.orderTimeLab.text = viewModel.totalStr;
    self.orderServiceModeLab.text = viewModel.serviceModeStr;
    
    self.orderPriceLab.text = viewModel.totalPriceStr;
    
    [self.orderBtn1 setTitle:viewModel.btn1TitleStr forState:UIControlStateNormal];
    self.orderBtn1.backgroundColor = viewModel.btn1BgColor;
    self.orderBtn1.hidden = viewModel.isBtn1Hidden;
    
    [self.orderBtn2 setTitle:viewModel.btn2TitleStr forState:UIControlStateNormal];
    self.orderBtn2.backgroundColor = viewModel.btn2BgColor;
    self.orderBtn2.hidden = viewModel.isBtn2Hidden;
    
}

#pragma mark - networking
- (void)getCurentOrder {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid
    uid = @"1";
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderList" params:@{@"uid": uid, @"type": @"1", @"start": @"0", @"limit": @"1"} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        
        if (0 == resArr.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.orderDateView.hidden = YES;
                self.orderInfoView.hidden = YES;
            });
        } else {
            NSDictionary *dic = resArr.firstObject;
            OrderModel *model = [[OrderModel alloc] initWithDic:dic];
            OrderViewModel *viewModel = [[OrderViewModel alloc] initWithOrderModel:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutOrderViewByOrderViewModel:viewModel];
            });
        }
    }];
}

#pragma mark - IBAction
- (IBAction)onTapTypeBtn:(id)sender {
    if (nil == _catView) {
        _catView = [[AdvisoryCatView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _catView.hidden = YES;
        [_catView makeKeyAndVisible];
        
        __weak typeof(self) weakSelf = self;
        _catView.selectedAdvisoryCatHandler = ^(NSNumber *selectedCatModel) {
            weakSelf.selectedCatModel = selectedCatModel.integerValue;
            [weakSelf performSegueWithIdentifier:@"ShowMastersListViewController" sender:weakSelf];
        };
    }
    
    [_catView show];
}

- (IBAction)onTapMyAdvisory:(id)sender {
    [self performSegueWithIdentifier:@"ShowMyAdvisory" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMastersListViewController"]) {
        MastersListViewController *controller = segue.destinationViewController;
        controller.selectedCatModel = self.selectedCatModel;
    }
}

@end

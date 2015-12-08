//
//  AdvisoryRootViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/2.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryRootViewController.h"
#import "MastersListViewController.h"
#import "OrderModel.h"
#import "CarouselCell.h"
#import "ArticleModel.h"
#import "PlazaDetailViewController.h"

@interface AdvisoryRootViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;

@property (weak, nonatomic) IBOutlet UILabel *noInfoLab;

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

@property (strong, nonatomic) NSMutableArray *headerDataArr;
@property (strong, nonatomic) NSURL *selectedHeaderUrl;
@property (assign, nonatomic) PlazaDetailParaType showDetailType;
@property (copy, nonatomic) NSString *showDetailTitleStr;
@end

@implementation AdvisoryRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerDataArr = [NSMutableArray new];
    
    [self.noInfoLab addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([UserConfigManager shareManager].isLogin) {
        [self getCurrentOrder];
    } else {
        self.orderInfoView.hidden = YES;
        self.orderDateView.hidden = YES;
        self.noInfoLab.hidden = NO;
        self.noInfoLab.text = @"请登录后查看";
    }
    
    [self getAdvisoryCarousel];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat btnWidth = (width - 5 * 2 - 6 * 3) / 4;
    CGFloat btnHeight = 26 / 17.0 * btnWidth;
    CGFloat height = 107 / 320.0 * width + 10 + 8 + 10 + btnHeight * 2 + 40 + (self.noInfoLab.hidden ? 31 + 164 : 86);
    self.contentHeightConstraint.constant = height + 6;
}

#pragma mark -
- (void)layoutHeaderViewSubviews {
    for (UIView *view in self.headerScrollView.subviews) {
        if ([view isKindOfClass:[CarouselCell class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger index = 0; index < self.headerDataArr.count; ++index) {
        ArticleViewModel *viewModel = [self.headerDataArr objectAtIndex:index];
        
        CarouselCell *cell = [[CarouselCell alloc] init];
        cell.tag = index;
        cell.url = viewModel.url;
        cell.titleStr = viewModel.titleStr;
        cell.frame = CGRectMake(index * self.headerScrollView.width, 0, self.headerScrollView.width, self.headerScrollView.height);
        [cell.imageView setImageWithURL:viewModel.imgUrl placeholderImage:[UIImage imageNamed:@"testHeader"]];
        [cell addTarget:self action:@selector(onTapCarouselCell:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerScrollView addSubview:cell];
    }
    
    self.headerScrollView.contentSize = CGSizeMake(self.headerScrollView.width * self.headerDataArr.count, self.headerScrollView.height);
}

- (void)onTapCarouselCell:(CarouselCell *)cell {
    self.showDetailType = PlazaDetailParaTypeOfUrl;
    self.selectedHeaderUrl = cell.url;
    self.showDetailTitleStr = cell.titleStr;
    [self performSegueWithIdentifier:@"ShowPlazaDetail" sender:self];
}

- (void)layoutOrderViewByOrderViewModel:(OrderViewModel *)viewModel {
    self.orderDateView.hidden = NO;
    self.orderInfoView.hidden = NO;
    self.noInfoLab.hidden = YES;
    
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

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"hidden"]) {
        [self.view setNeedsUpdateConstraints];
    }
}

#pragma mark - networking
- (void)getAdvisoryCarousel {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"newsList" params:@{@"push": @"34"} success:^(id responseObject) {
        
        [self.headerDataArr removeAllObjects];
        
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            ArticleModel *model = [[ArticleModel alloc] initWithDic:dic];
            ArticleViewModel *viewModel = [[ArticleViewModel alloc] initWithArticleModel:model];
            [self.headerDataArr addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutHeaderViewSubviews];
        });
    }];
}

- (void)getCurrentOrder {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderList" params:@{@"uid": uid, @"type": @"1", @"start": @"0", @"limit": @"1"} success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        
        if (0 == resArr.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.noInfoLab.text = @"没有进行中的订单";
                self.noInfoLab.hidden = NO;
                self.orderDateView.hidden = YES;
                self.orderInfoView.hidden = YES;
            });
        } else {
            NSDictionary *dic = resArr.firstObject;
            OrderModel *model = [[OrderModel alloc] initWithDic:dic];
            self.orderViewModel = [[OrderViewModel alloc] initWithOrderModel:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutOrderViewByOrderViewModel:self.orderViewModel];
            });
        }
    }];
}

- (void)cancelCurrentOrder {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderCancel" params:@{@"uid": uid, @"orderid": self.orderViewModel.orderIdStr} success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getCurrentOrder];
        });
    }];
}

- (void)completCurrentOrder {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"orderStatus" params:@{@"uid": uid, @"orderid": self.orderViewModel.orderIdStr} success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getCurrentOrder];
        });
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
    
    UIButton *btn = (UIButton *)sender;
    
    [UserConfigManager shareManager].createOrderViewModel.problemNumStr = [NSString stringWithFormat:@"%zd", btn.tag];
    
    [_catView show];
}

- (IBAction)onTapMyAdvisory:(id)sender {
    [self performSegueWithIdentifier:@"ShowMyAdvisory" sender:self];
}

- (IBAction)onTapOrderBtn:(id)sender {
    UIButton *btn = sender;
    if ([btn.titleLabel.text isEqualToString:@"取消订单"]) {
        [CustomTools alertShow:@"您确认取消订单吗？" content:@"一天内3次取消订单，当日将不能再平台预约！\n如果订单已经支付\n1.)资费全部退还（取消订单时间>1小时）\n2.)扣除资费20%违约金（取消订单时间<1小时）" cancelBtnTitle:@"再想想" okBtnTitle:@"确定" container:self];
    } else if ([btn.titleLabel.text isEqualToString:@"付款"]) {
        
    } else if ([btn.titleLabel.text isEqualToString:@"电话沟通"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", self.orderViewModel.telStr]]];
    } else if ([btn.titleLabel.text isEqualToString:@"完成"]) {
        [self completCurrentOrder];
    } else if ([btn.titleLabel.text isEqualToString:@"评价"]) {
        
    } else if ([btn.titleLabel.text isEqualToString:@"再次预约"]) {
        
    } else {
        
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMastersListViewController"]) {
        MastersListViewController *controller = segue.destinationViewController;
        controller.selectedCatModel = self.selectedCatModel;
    } else if ([segue.identifier isEqualToString:@"ShowPlazaDetail"]) {
        PlazaDetailViewController *vc = segue.destinationViewController;
        vc.title = self.showDetailTitleStr;
        vc.url = self.selectedHeaderUrl;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self cancelCurrentOrder];
    }
}

@end

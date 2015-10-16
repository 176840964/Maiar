//
//  WithdrawalViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/31.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "ApplyMoneyModel.h"
#import "BankViewController.h"
#import "BankCityViewController.h"

@interface WithdrawalViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *markView;

//zhifubao
@property (weak, nonatomic) IBOutlet UITextField *aliAccoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *aliNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *aliMoneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *aliCommitBtn;

//bank
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *bankIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankAddrLab;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankUserNameField;
@property (weak, nonatomic) IBOutlet UITextField *bankMoneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *bankCommitBtn;

@property (strong, nonatomic) ApplyMoneyViewModel *applyMoneyViewModel;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getApplyMoney];
    [self setupRACSignal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.bankNameLab.text = self.applyMoneyViewModel.bankNameStr;
    CGRect rect = [self.bankNameLab textRectForBounds:CGRectMake(120, 0, 258, 44) limitedToNumberOfLines:1];
    self.bankNameLab.width = CGRectGetWidth(rect);
    
    [self.bankIconImageView setImageWithURL:self.applyMoneyViewModel.bankImgUrl];
    self.bankIconImageView.x = CGRectGetMaxX(self.bankNameLab.frame) + 5;
    
    self.bankAddrLab.text = self.applyMoneyViewModel.areaStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.widthConstraint.constant = self.view.width * 2;
}

#pragma mark - 
- (void)layoutSubviews {
    if (self.applyMoneyViewModel.isBankPay) {
        [self onTapBankCardBtn:nil];
    } else {
        [self onTapZhifubaoBtn:nil];
    }
    
    self.aliMoneyTextField.placeholder = self.applyMoneyViewModel.balanceStr;
    self.bankMoneyTextField.placeholder = self.applyMoneyViewModel.balanceStr;
}

- (void)setupRACSignal {
    {//zhifubao
        RACSignal *validAliAccoutField = [self.aliAccoutTextField.rac_textSignal map:^id(NSString *text) {
            return @([text isKindOfClass:[NSString class]] && 0 < text.length);
        }];
        RACSignal *validAliNameField = [self.aliNameTextField.rac_textSignal map:^id(NSString *text) {
            return @([text isKindOfClass:[NSString class]] && 0 < text.length);
        }];
        RACSignal *validAliMoneyField = [self.aliMoneyTextField.rac_textSignal map:^id(NSString *text) {
            return @([text isKindOfClass:[NSString class]] && 0 < text.length);
        }];
        
        RAC(self.aliCommitBtn, enabled) = [RACSignal combineLatest:@[validAliAccoutField, validAliNameField, validAliMoneyField] reduce:^id (NSNumber *accoutValid, NSNumber *nameValid, NSNumber *moneyValid){
            if (accoutValid.boolValue && nameValid.boolValue && moneyValid.boolValue) {
                self.aliCommitBtn.backgroundColor = [UIColor colorWithHexString:@"#bb57f4"];
            } else {
                self.aliCommitBtn.backgroundColor = [UIColor lightGrayColor];
            }
            
            return @(accoutValid.boolValue && nameValid.boolValue && moneyValid.boolValue);
        }];
    }
    {//bank
        RACSignal *validBankCardField = [self.bankCardTextField.rac_textSignal map:^id(NSString *text) {
            return @([text isKindOfClass:[NSString class]] && 0 < text.length);
        }];
        RACSignal *validBankUserNameField = [self.bankUserNameField.rac_textSignal map:^id(NSString *text) {
            return @([text isKindOfClass:[NSString class]] && 0 < text.length);
        }];
        RACSignal *validBankMoneyField = [self.bankMoneyTextField.rac_textSignal map:^id(NSString *text) {
            return @([text isKindOfClass:[NSString class]] && 0 < text.length);
        }];
        
        RAC(self.bankCommitBtn, enabled) = [RACSignal combineLatest:@[validBankCardField, validBankUserNameField, validBankMoneyField] reduce:^id(NSNumber *cardValid, NSNumber *userNameValid, NSNumber *moneyValid) {
            BOOL isValidBankId = ([self.applyMoneyViewModel.bankIdStr isKindOfClass:[NSString class]] && 0 < self.applyMoneyViewModel.bankIdStr.length);
            BOOL isValidBankAreaId = ([self.applyMoneyViewModel.areaIdStr isKindOfClass:[NSString class]] && 0 < self.applyMoneyViewModel.bankIdStr.length);
            BOOL isValid = (isValidBankId && isValidBankAreaId && cardValid.boolValue && userNameValid.boolValue && moneyValid.boolValue);
            if (isValid) {
                self.bankCommitBtn.backgroundColor = [UIColor colorWithHexString:@"#bb57f4"];
            } else {
                self.bankCommitBtn.backgroundColor = [UIColor lightGrayColor];
            }
            
            return @(isValid);
        }];
    }
}

#pragma mark - NetWorking
- (void)getApplyMoney {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
#warning test uid
    uid = @"1";
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"getApplyMoney" params:@{@"uid": uid} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        ApplyMoneyModel *model = [[ApplyMoneyModel alloc] initWithDic:resDic];
        self.applyMoneyViewModel = [[ApplyMoneyViewModel alloc] initWithApplyMoneyModel:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutSubviews];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapZhifubaoBtn:(id)sender {
    self.markView.transform = CGAffineTransformIdentity;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)onTapBankCardBtn:(id)sender {
    self.markView.transform = CGAffineTransformMakeTranslation(self.view.width / 2.0, 0);
    [self.scrollView setContentOffset:CGPointMake(self.view.width, 0) animated:YES];
}

- (IBAction)onTapZhifubaoCommitBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowCommitSuccessViewController" sender:self];
}

- (IBAction)onTapBankCommitBtn:(id)sender {
    [self performSegueWithIdentifier:@"ShowCommitSuccessViewController" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:self];
    if ([segue.identifier isEqualToString:@"ShowBankViewController"]) {
        BankViewController *controller = segue.destinationViewController;
        controller.selectedBackIdStr = self.applyMoneyViewModel.bankTypeStr;
        controller.didSelectedHandle = ^ (BankViewModel *bankViewModel) {
            [self.applyMoneyViewModel setValuesByBankViewModel:bankViewModel];
        };
    } else if ([segue.identifier isEqualToString:@"ShowBankCityViewController"]) {
        BankCityViewController *controller = segue.destinationViewController;
        controller.selectedAreaIdStr = self.applyMoneyViewModel.areaIdStr;
        controller.didSelectedHandle = ^ (AreaViewModel *areaViewModel) {
            [self.applyMoneyViewModel setvaluesByBankAreaViewModel:areaViewModel];
        };
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (0 == scrollView.contentOffset.x) {
        self.markView.transform = CGAffineTransformIdentity;
    } else {
        self.markView.transform = CGAffineTransformMakeTranslation(self.view.width / 2.0, 0);
    }
}

@end

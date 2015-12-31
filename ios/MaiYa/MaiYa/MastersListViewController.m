//
//  MastersListViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/6.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "MastersListViewController.h"
#import "MasterCell.h"
#import "FillterView.h"
#import "MyZoneViewController.h"
#import "MasterListParaModel.h"

@interface MastersListViewController () <UITableViewDataSource, UITableViewDelegate, CustomTableViewViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArr;
@property (weak, nonatomic) IBOutlet CustomTableView *tableView;
@property (weak, nonatomic) IBOutlet FillterView *fillterView;
@property (weak, nonatomic) IBOutlet UIView *markView;

@property (strong, nonatomic) MasterListParaModel *paraModel;
@property (strong, nonatomic) NSMutableArray *usersArr;
@property (strong, nonatomic) UserZoneViewModel *selectedMasterViewModel;
@end

@implementation MastersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.customDelegate = self;
    [self.tableView setUpSubviewsIsCanRefresh:YES andIsCanReloadMore:YES];
    
    self.usersArr = [NSMutableArray new];
    self.paraModel = [[MasterListParaModel alloc] initWithCatStr:[NSString stringWithFormat:@"%zd", self.selectedCatModel]];
    [self.paraModel addObserver:self forKeyPath:@"isNeedReloadData" options:0 context:nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
    
    [self getUserList];
    
    [self.fillterView setupDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.btnsArr = [self.btnsArr sortByUIViewOriginX];
    [self.fillterView layoutViewDidAppear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.paraModel removeObserver:self forKeyPath:@"isNeedReloadData"];
}

#pragma mark - 
- (void)showFillterView {
    if (self.fillterView.hidden) {
        self.fillterView.hidden = NO;
        
        UIButton *btn = [self.btnsArr lastObject];
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#7167aa"];
        
        self.fillterView.transform = CGAffineTransformMakeTranslation(0, -self.fillterView.height);
        [UIView animateWithDuration:.5 animations:^{
            self.fillterView.transform = CGAffineTransformIdentity;
            self.markView.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)closeFillterView {
    if (!self.fillterView.hidden) {
        UIButton *btn = [self.btnsArr lastObject];
        btn.selected = NO;
        btn.backgroundColor = self.view.backgroundColor;
        
        [UIView animateWithDuration:.5 animations:^{
            self.fillterView.transform = CGAffineTransformMakeTranslation(0, -self.fillterView.height);
            self.markView.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.fillterView.hidden = YES;
        }];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isNeedReloadData"]) {
        if (self.paraModel.isNeedReloadData) {
            self.paraModel.start = @"0";
            [self getUserList];
            self.paraModel.isNeedReloadData = NO;
        }
    }
}

#pragma mark - Networking
- (void)getUserList {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userList" params:self.paraModel.dic success:^(id responseObject) {
        NSMutableArray *usersArr = [NSMutableArray new];
        
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            UserZoneModel *model = [[UserZoneModel alloc] initWithDic:dic];
            UserZoneViewModel *viewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
            [usersArr addObject:viewModel];
        }
        
        if (self.tableView.type == CustomTableViewUpdateTypeReloadMore) {
            [self.usersArr addObjectsFromArray:usersArr];
            [self.tableView finishReloadMoreDataWithIsEnd:(0 == usersArr.count)];
        } else {
            self.usersArr = usersArr;
            [self.tableView finishRefreshData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (usersArr.count == 0 && [self.paraModel.start isEqualToString:@"0"]) {
                [[HintView getInstance] presentMessage:@"没有找到咨询师" isAutoDismiss:NO dismissTimeInterval:1 dismissBlock:^{
                }];
            }
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapSortBtn:(id)sender {
    UIButton *button = (id)sender;
    if (button.selected && 3 != button.tag) {
        return;
    }
    
    if (3 != button.tag) {
        for (UIButton *btn in self.btnsArr) {
            if (3 == btn.tag) {
                continue;
            }
            btn.selected = NO;
            btn.backgroundColor = self.view.backgroundColor;
        }
    }
    
    if (3 == button.tag) {
        if (!self.fillterView.hidden) {
            [self closeFillterView];
            
            self.paraModel.money_s = self.fillterView.minPrice;
            self.paraModel.money_e = self.fillterView.maxPrice;
            self.paraModel.time = self.fillterView.timeFillterStr;
            
            self.paraModel.isNeedReloadData = self.paraModel.isChangeMoney_e || self.paraModel.isChangeMoney_s || self.paraModel.isChangeTime;
        } else {
            [self showFillterView];
        }
    } else {
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#7167aa"];
        
        switch (button.tag) {
            case 0:
                self.paraModel.distance = @"1";
                self.paraModel.order = nil;
                break;
            case 1:
                self.paraModel.distance = nil;
                self.paraModel.order = OrderTypeOfCommentNum;
                break;
            default:
                self.paraModel.distance = nil;
                self.paraModel.order = OrderTypeOfHourMoney;
                break;
        }
        
        self.paraModel.isNeedReloadData = YES;
    }
}

- (IBAction)onTapMarkViewGestureRecognizer:(id)sender {
    [self closeFillterView];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMasterZone"]) {
        MyZoneViewController *contrller = segue.destinationViewController;
        contrller.type = ZoneViewControllerTypeOfOther;
        contrller.cidStr = self.selectedMasterViewModel.uidStr;
        contrller.title = self.selectedMasterViewModel.nickStr;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    
    UserZoneViewModel *viewModel = [self.usersArr objectAtIndex:indexPath.row];
    [cell layoutMasterCellSubviewsByUserZoneViewModel:viewModel];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserZoneViewModel *viewModel = [self.usersArr objectAtIndex:indexPath.row];
    self.selectedMasterViewModel = viewModel;
    
    [self performSegueWithIdentifier:@"ShowMasterZone" sender:self];
}

#pragma mark - CustomTableViewViewDelegate
- (void)customTableViewRefresh:(CustomTableView*)customTableView {
    self.paraModel.start = @"0";
    [self getUserList];
}

- (void)customTableViewReloadMore:(CustomTableView*)customTableView {
    self.paraModel.start = [NSString stringWithFormat:@"%zd", self.usersArr.count];
    [self getUserList];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView.refreshView refreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView.refreshView refreshScrollViewDidScroll:scrollView];
    [self.tableView.reloadMoreView scrollViewDidScroll:scrollView];
}

@end

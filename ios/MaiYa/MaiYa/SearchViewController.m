//
//  SearchViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/6.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "SearchViewController.h"
#import "MasterCell.h"
#import "MyZoneViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (copy, nonatomic) NSString *selectedMasterId;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchResults = [NSMutableArray new];
    
    self.searchDisplayController.searchBar.tintColor = [UIColor whiteColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"MasterCell" bundle:nil];
    [self.searchDisplayController.searchResultsTableView registerNib:cellNib forCellReuseIdentifier:@"MasterCell"];
    self.searchDisplayController.searchResultsTableView.rowHeight = 77;
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NetWorking
- (void)getUserListByKeyWordStr:(NSString *)keyWordStr {
    NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:uid forKey:@"uid"];
    
    if (keyWordStr.isValid) {
        [dic setObject:keyWordStr forKey:@"fuzzy"];
    }
    
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"userList" params:dic success:^(id responseObject) {
        NSArray *resArr = [responseObject objectForKey:@"res"];
        for (NSDictionary *dic in resArr) {
            UserZoneModel *model = [[UserZoneModel alloc] initWithDic:dic];
            UserZoneViewModel *viewModel = [[UserZoneViewModel alloc] initWithUserZoneModel:model];
            [self.searchResults addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (0 == self.searchResults.count) {
                UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
                for( UIView *subview in tableView1.subviews ) {
                    if( [subview class] == [UILabel class] ) {
                        UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                        lbl.text = @"没有结果";
                    }
                }
            } else {
                [self.searchDisplayController.searchResultsTableView reloadData];
            }
        });
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMasterZone"]) {
        MyZoneViewController *contrller = segue.destinationViewController;
        contrller.type = ZoneViewControllerTypeOfOther;
        
        NSString *uid = [UserConfigManager shareManager].userInfo.uidStr;
        contrller.cidStr = self.selectedMasterId;
        contrller.oidStr = uid;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    
    UserZoneViewModel *viewModel = [self.searchResults objectAtIndex:indexPath.row];
    [cell layoutMasterCellSubviewsByUserZoneViewModel:viewModel];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserZoneViewModel *viewModel = [self.searchResults objectAtIndex:indexPath.row];
    self.selectedMasterId = viewModel.uidStr;
    
    [self performSegueWithIdentifier:@"ShowMasterZone" sender:self];
}


#pragma mark - UISearchDisplayDelegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self getUserListByKeyWordStr:searchString];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    [searchBar setShowsCancelButton:YES animated:YES];
    for(UIView *subView in searchBar.subviews){
        if([subView isKindOfClass:UIButton.class]){
            [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

@end
